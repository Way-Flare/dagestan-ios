//
//  UserChangePhotoView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
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
            guard data.count <= 15_000_000 else { // 15 MB
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
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerImage: Image?
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: Grid.pt16) {
            getPhotoView()
            getPhotoPickerView()

            Spacer()
        }
        .padding(.horizontal, Grid.pt16)
        .onChange(of: pickerItem) { _ in
            loadPhoto()
        }
    }
}

extension UserChangePhotoView {
    @ViewBuilder
    func getPhotoView() -> some View {
        if pickerImage == nil {
            WFAvatarView.initials(
                "GR",
                userId: UUID().uuidString,
                size: .size186
            )
        } else {
            pickerImage?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Grid.pt186, height: Grid.pt186)
                .clipShape(Circle())
        }
    }

    func getPhotoPickerView() -> some View {
        PhotosPicker(
            selection: $pickerItem,
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
            guard let pickerItem = pickerItem else {
                print("No image selected")
                return
            }

            do {
                guard let loadedImage = try await pickerItem.loadTransferable(type: TransferableImage.self) else {
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

                if FileManagerHelper.saveImage(imageData, withName: "cachedUserPhoto.jpg") {
                    print("Image saved successfully")
                    DispatchQueue.main.async {
                        self.pickerImage = Image(uiImage: uiImage)
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }
        }
    }
}
