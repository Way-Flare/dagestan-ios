//
//  ProfileChangeBackgroundImageView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 05.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import PhotosUI
import SwiftUI

struct ProfileChangeBackgroundImageView: View {
    @State var offset: CGFloat = .zero
    @State var selectedItem: PhotosPickerItem?
    @State var image: Image?
    @State var data: Data?
    let profile: Profile

    var body: some View {
        ScrollViewWithScrollOffset(scrollOffset: $offset) {
            VStack(spacing: .zero) {
                ProfileImageView(offset: $offset, image: $image)
                menuSection
                    .overlay(
                        profileCircle,
                        alignment: .top
                    )
                    .offset(y: -Grid.pt24)
            }
        }
        .coordinateSpace(name: "pullToResize")
        .ignoresSafeArea()
        .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
        .setCustomBackButton()
        .onChange(of: selectedItem) { _ in
            selectedItem?.loadTransferable(type: TransferableImage.self) { result in
                DispatchQueue.global(qos: .userInitiated).async {
                    switch result {
                        case .success(let givenData):
                            DispatchQueue.main.async {
                                self.image = givenData?.image
                                self.data = givenData?.imageData
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                print(error)
                            }
                    }
                }
            }
        }
        .onAppear {
            if let uiImage = FileManagerHelper.loadImage(withName: "background_profile") {
                image = Image(uiImage: uiImage)
            }
        }
    }

    private var menuSection: some View {
        VStack(spacing: Grid.pt12) {
            getPhotoPickerView()
            
            WFButton(
                title: "Сохранить",
                size: .l,
                state: .default,
                type: .primary
            ) {
                if let data {
                    FileManagerHelper.saveImage(data, withName: "background_profile")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Grid.pt108)
        .padding(.horizontal, Grid.pt12)
        .frame(maxHeight: .infinity)
        .background(WFColor.surfaceSecondary)
        .cornerRadius(Grid.pt24)
    }

    func getPhotoPickerView() -> some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            WFButton(
                title: "Поменять фото заднего фона",
                size: .l,
                type: .secondary
            ) {

            }.allowsHitTesting(false)
        }
    }

    private var profileCircle: some View {
        VStack(spacing: Grid.pt8) {
            UserPhotoImageView(url: profile.avatar)

            if let username = profile.username {
                Text(username)
                    .foregroundColor(WFColor.foregroundPrimary)
                    .font(.manropeSemibold(size: Grid.pt18))
            } else {
                makeRectangle()
            }
            if let email = profile.email {
                Text(email)
                    .foregroundColor(WFColor.foregroundSoft)
                    .font(.manropeSemibold(size: Grid.pt18))
            }
        }
        .offset(y: -Grid.pt65)
    }

    private func makeRectangle() -> some View {
        Rectangle()
            .fill()
            .frame(width: 62, height: 34)
            .skeleton()
            .cornerStyle(.constant(Grid.pt8))
    }
}

#Preview {
    ProfileChangeBackgroundImageView(profile: .init(id: 21412, avatar: nil, username: "gleb", phone: "+79818363211", email: nil))
}
