//
//  IProfileService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

protocol IProfileService {
    func getProfile() async throws -> Profile
    func patchProfile(request: ProfileEndpoint.PatchType) async throws -> Profile
    func deleteProfile() async throws
}
