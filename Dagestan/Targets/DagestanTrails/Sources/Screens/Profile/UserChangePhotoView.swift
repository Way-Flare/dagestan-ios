//
//  UserChangePhotoView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import PhotosUI
import SwiftUI

struct TransferableImage: Transferable {
    let image: Image
    let imageData: Data

    enum TransferError: Error {
        case importFailed, imageSizeTooLarge
    }

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard data.count <= 15_000_000 else {
                throw TransferError.imageSizeTooLarge
            }

            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return TransferableImage(image: image, imageData: data)
        }
    }
}

struct UserChangePhotoView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let username: String?
    let avatar: URL?

    var body: some View {
        VStack(spacing: Grid.pt16) {
            getPhotoView()
            getPhotoPickerView()

            Spacer()
        }
        .padding(.horizontal, Grid.pt16)
        .onChange(of: viewModel.pickerItem) { _ in
            loadPhoto()
        }
        .setCustomNavigationBarTitle(title: "Фото профиля")
        .setCustomBackButton()
    }
}

extension UserChangePhotoView {
    @ViewBuilder
    func getPhotoView() -> some View {
        if let image = viewModel.pickerImage {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Grid.pt186, height: Grid.pt186)
                .clipShape(Circle())
        } else if let avatar {
            LazyImage(url: avatar) { state in
                state.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 186, height: 186)
                    .skeleton(show: state.isLoading, cornerStyle: .round)
                    .cornerStyle(.round)
            }
        } else if viewModel.pickerImage == nil {
            WFAvatarView.initials(
                username,
                userId: UUID().uuidString,
                size: .size186
            )
        }
    }

    func getPhotoPickerView() -> some View {
        PhotosPicker(
            selection: $viewModel.pickerItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            WFButton(
                title: "Изменить фото",
                size: .l,
                type: .secondary
            ) {}.allowsHitTesting(false)
        }
    }
}

extension UserChangePhotoView {
    func loadPhoto() {
        Task {
            guard let _ = viewModel.pickerItem else {
                print("No image selected")
                return
            }

            do {
                guard let loadedImage = try await viewModel.pickerItem?.loadTransferable(type: TransferableImage.self) else {
                    return
                }
                guard let uiImage = UIImage(data: loadedImage.imageData) else {
                    print("Failed to convert data to UIImage")
                    return
                }
                guard let imageData = uiImage.jpegData(compressionQuality: 1.0) else {
                    print("Failed to get JPEG representation of UIImage")
                    return
                }

                if imageData.count > 15_000_000 { // 15 MB
                    print("Image is too large")
                    return
                }

                DispatchQueue.main.async {
                    viewModel.pickerImage = Image(uiImage: uiImage)

                    if let data = uiImage.jpegData(compressionQuality: 0.0) {
                        viewModel.patchProfile(with: .photo(value: data))
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }
        }
    }
}
