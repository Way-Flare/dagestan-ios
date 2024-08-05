//
//  ReviewView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 31.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import DesignSystem
import NukeUI
import PhotosUI
import SwiftUI

public struct ReviewModel: Identifiable {
    public var id: Int
    public let image: URL?
    public let name: String
    public let address: String?
    public let rating: Double
    public let feedbackCount: Int
}

class ReviewViewModel: ObservableObject {
    @Published var text = ""
    @Published var pickerItems: [PhotosPickerItem] = []
    @Published var selectedImages: [UIImage] = []
    @Published var sendStatus: LoadingState<Bool> = .idle
    @Published var showAlert = false

    @Published var rating: Int

    private let service: IFeedbackService

    init(service: IFeedbackService = FeedbackService(networkService: DTNetworkService()), rating: Int) {
        self.service = service
        self.rating = rating
    }

    @MainActor
    func sendReview(by id: Int, fromPlace value: Bool) {
        sendStatus = .loading

        Task {
            do {
                let photos = selectedImages.compactMap { $0.jpegData(compressionQuality: 1.0) }

                let review = FeedbackEndpoint.FeedbackReview(
                    id: id,
                    stars: rating,
                    comment: text,
                    images: photos
                )

                let _ = try await service.addFeedback(review: review, isPlace: value)
                sendStatus = .loaded(true)
            } catch {
                showAlert = true
                if let error = error as? RequestError {
                    sendStatus = .failed(error.message)
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func loadImages() {
        selectedImages.removeAll()

        for item in pickerItems {
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let imageData):
                    if let data = imageData,
                       let image = UIImage(data: data)
                    {
                        DispatchQueue.main.async {
                            self.selectedImages.append(image)
                        }
                    }
                case .failure(let error):
                    print("Error loading image data: \(error)")
                }
            }
        }
    }
}

struct ReviewView: View {
    @StateObject var viewModel: ReviewViewModel
    @Environment(\.dismiss) var dismiss
    @State private var editorHeight: CGFloat = 100
    @Binding var rating: Int
    var onSuccessSaveButton: (() -> Void)?
    let isPlaces: Bool

    init(
        initialRating: Binding<Int>,
        review: ReviewModel,
        onSaveButton: (() -> Void)? = nil,
        isPlaces: Bool
    ) {
        self._viewModel = StateObject(wrappedValue: ReviewViewModel(rating: initialRating.wrappedValue))
        self._rating = initialRating
        self.review = review
        self.onSuccessSaveButton = onSaveButton
        self.isPlaces = isPlaces
    }

    let review: ReviewModel

    var body: some View {
        VStack(spacing: 14) {
            VStack(spacing: 22) {
                Rectangle()
                    .fill()
                    .foregroundStyle(WFColor.surfaceFivefold)
                    .frame(width: 36, height: 4)
                    .cornerStyle(.constant(5))

                Text("Оставьте отзыв")
                    .font(.manropeExtrabold(size: 20))
                    .foregroundStyle(WFColor.foregroundPrimary)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) { CloseButton() }
            }
            .padding(.top, 8)
            .padding(.horizontal, 12)

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    LazyImage(url: review.image) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .frame(height: 207)
                                .frame(maxWidth: .infinity)
                                .cornerStyle(.constant(12))
                                .padding(.top, 8)
                        } else {
                            DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                                .resizable()
                                .frame(height: 207)
                                .frame(maxWidth: .infinity)
                                .cornerStyle(.constant(12))
                                .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 12)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(review.name)
                            .font(.manropeSemibold(size: 18))
                            .foregroundStyle(WFColor.foregroundPrimary)
                        if let address = review.address {
                            Text(address)
                                .font(.manropeRegular(size: 14))
                                .foregroundStyle(WFColor.foregroundSoft)
                                .lineLimit(nil)
                        }
                    }
                    .padding(.horizontal, 12)

                    if viewModel.pickerItems.isEmpty {
                        getMaxWidthPhotoPickerView()
                            .padding(.horizontal, 12)
                    } else {
                        getPhotoPickerViewWithPhotos()
                            .padding(.horizontal, 12)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        VStack(spacing: 16) {
                            Text("Поставьте оценку месту")
                                .font(.manropeRegular(size: 14))
                                .foregroundStyle(WFColor.foregroundPrimary)
                            StarsView(amount: rating, size: .l) { rating in
                                self.rating = rating
                                viewModel.rating = rating
                            }
                        }
                        .frame(height: 102)
                        .frame(maxWidth: .infinity)
                        .background(WFColor.surfacePrimary)
                        .cornerStyle(.constant(12))

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Расскажите о месте подробнее")
                                .font(.manropeRegular(size: 14))
                                .foregroundStyle(WFColor.foregroundSoft)
                            ExpandingTextView(text: $viewModel.text)
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)

                    VStack(spacing: .zero) {
                        Divider()
                            .background(WFColor.borderMuted)
                        WFButton(
                            title: "Сохранить",
                            size: .m,
                            state: viewModel.sendStatus.isLoading ? .loading : .default,
                            type: .primary
                        ) {
                            viewModel.sendReview(by: review.id, fromPlace: isPlaces)
                        }
                        .onChange(of: viewModel.sendStatus) { status in
                            if let _ = status.data  {
                                dismiss()
                                onSuccessSaveButton?()
                            }
                        }
                        .padding(12)
                    }
                    .frame(height: 68)
                    .background(WFColor.surfaceSecondary)
                }
            }
        }
        .scrollIndicators(.hidden)
        .alert("Ошибка", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            if let error = viewModel.sendStatus.error {
                Text(error)
                    .foregroundStyle(WFColor.foregroundPrimary)
                    .font(.manropeRegular(size: Grid.pt20))
                    .multilineTextAlignment(.center)
            }
        }
        .onChange(of: viewModel.pickerItems) { _ in
            viewModel.loadImages()
        }
        .frame(width: 400)
        .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
    }

    private func getMaxWidthPhotoPickerView() -> some View {
        PhotosPicker(
            selection: $viewModel.pickerItems,
            maxSelectionCount: 10,
            matching: .images,
            photoLibrary: .shared()
        ) {
            HStack(spacing: 10) {
                DagestanTrailsAsset.galleryAddLinear.swiftUIImage
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Добавить фотографию")
                    .font(.manropeRegular(size: 14))
            }
            .foregroundStyle(WFColor.accentPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 98)
            .background(WFColor.surfacePrimary)
            .cornerStyle(.constant(12))
        }
    }

    private func getPhotoPickerViewWithPhotos() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                getAddPhotoView()
                ForEach(0 ..< viewModel.selectedImages.count, id: \.self) { index in
                    Image(uiImage: viewModel.selectedImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()
            }
        }
        .foregroundStyle(WFColor.accentPrimary)
        .frame(maxWidth: .infinity)
        .frame(height: 98)
        .padding(.horizontal, 12)
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(12))
    }

    private func getAddPhotoView() -> some View {
        PhotosPicker(
            selection: $viewModel.pickerItems,
            maxSelectionCount: 10,
            matching: .images,
            photoLibrary: .shared()
        ) {
            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(width: 80, height: 80)
                    .cornerStyle(.constant(5))
                    .foregroundColor(.gray)

                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 80, height: 80)
        }
    }
}

struct ExpandingTextView: View {
    @Binding var text: String
    @State private var textHeight: CGFloat = 44

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(minHeight: textHeight, maxHeight: .infinity)
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: 16))
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(WFColor.surfacePrimary)
                .setBorder()
                .cornerStyle(.constant(8))

                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
                .onChange(of: text) { _ in
                    self.updateTextHeight()
                }

            if text.isEmpty {
                Text("Что было хорошо, а что не понравилось")
                    .foregroundColor(WFColor.foregroundSoft)
                    .font(.manropeRegular(size: 16))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .allowsHitTesting(false)
            }
        }
    }

    private func updateTextHeight() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude))
        textView.text = text
        textView.font = UIFont.manropeRegular(size: 16)
        textView.textColor = WFColor.foregroundPrimary.uiColor()
        textView.sizeToFit()
        textHeight = textView.frame.height
    }
}

extension Color {
    func uiColor() -> UIColor {
        let components = self.components()
        return UIColor(
            red: components.red,
            green: components.green,
            blue: components.blue,
            alpha: components.alpha
        )
    }

    // swiftlint: disable large_tuple
    private func components() -> (
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat
    ) {
        let scanner = Scanner(string: description.trimmingCharacters(in: .alphanumerics))
        var hexNumber: UInt64 = 0
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1

        var result = scanner.scanHexInt64(&hexNumber)
        if result {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x0000ff) / 255
            alpha = CGFloat(hexNumber & 0x000000ff) / 255
        }

        return (red, green, blue, alpha)
    }

    // swiftlint: enable large_tuple
}
