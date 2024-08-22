//
//  ProfileViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import PhotosUI
import SwiftUI
import UIKit

// TODO: Запихать под протокол
final class ProfileViewModel: ObservableObject {
    @Published var pickerItem: PhotosPickerItem?
    @Published var pickerImage: Image?
    @Published var offset: CGFloat = .zero
    @Published var profileState: LoadingState<Profile> = .idle
    @Published var isShowAlert = false
    @Published var isShouldChangeName = false
    @Published var username = ""
    @Published var email = ""
    @Published var backgroundImage: Image?
    
    private let service: IProfileService
    
    init(service: IProfileService = ProfileService(networkService: DTNetworkService())) {
        self.service = service
    }
    
    func loadProfile() {
        profileState = .loading
        isShowAlert = false

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let profile = try await service.getProfile()
                profileState = .loaded(profile)
                if profile.username?.lowercased() == "user" {
                    isShouldChangeName = true
                }
                saveName(with: profile.username)
            } catch {
                profileState = .failed(error.localizedDescription)
                isShowAlert = true
            }
        }
    }
    
    func patchProfile(with request: ProfileEndpoint.PatchType) {
        profileState = .loading
        
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let profile = try await service.patchProfile(request: request)
                self.profileState = .loaded(profile)
                if profile.username?.lowercased() != "user" {
                    isShouldChangeName = false
                }
            } catch {
                self.profileState = .failed(error.localizedDescription)
            }
        }
    }
    
    func deleteProfile() {
        profileState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                try await service.deleteProfile()
                profileState = .idle
                UserDefaults.standard.setValue(false, forKey: "isAuthorized")
            } catch {
                profileState = .failed(error.localizedDescription)
            }
        }
    }
    
    private func saveName(with name: String?) {
        if UserDefaults.standard.string(forKey: "username") != name {
            UserDefaults.standard.setValue(name, forKey: "username")
        }
    }
}
