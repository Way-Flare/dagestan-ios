//
//  ProfileViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var offset: CGFloat = .zero
    @Published var profileState: LoadingState<Profile> = .idle
    @Published var username = ""
    @Published var email = ""
    
    private let service: IProfileService
    
    init(service: IProfileService = ProfileService(networkService: DTNetworkService())) {
        self.service = service
        loadProfile()
    }
    
    func loadProfile() {
        profileState = .loading
        
        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let profile = try await service.getProfile()
                profileState = .loaded(profile)
            } catch {
                profileState = .failed(error.localizedDescription)
            }
        }
    }
    
    func patchProfile(with request: ProfileRequestDTO) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            do {
                let profile = try await service.patchProfile(request: request)
                self.profileState = .loaded(profile)
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
            } catch {
                profileState = .failed(error.localizedDescription)
            }
        }
    }
}