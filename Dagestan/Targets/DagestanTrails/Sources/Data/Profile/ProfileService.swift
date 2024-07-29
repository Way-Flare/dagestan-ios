//
//  ProfileService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit

class ProfileService: IProfileService {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProfile() async throws -> Profile {
        let endpoint = ProfileEndpoint.getProfile
        do {
            let profile = try await networkService.execute(endpoint, expecting: ProfileDTO.self)
            return profile.asDomain()
        } catch {
            throw error
        }
    }
    
    func patchProfile(request: ProfileRequestDTO) async throws -> Profile {
        let endpoint = ProfileEndpoint.patchProfile(request: request)
        do {
            let profile = try await networkService.execute(endpoint, expecting: ProfileDTO.self)
            return profile.asDomain()
        } catch {
            throw error
        }
    }
    
    func deleteProfile() async throws {
        let endpoint = ProfileEndpoint.deleteProfile
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }
}
