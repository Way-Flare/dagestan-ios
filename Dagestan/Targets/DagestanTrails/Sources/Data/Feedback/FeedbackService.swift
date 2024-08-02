//
//  FeedbackService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import CoreKit

class FeedbackService: IFeedbackService {
    private let networkService: INetworkService

    init(networkService: INetworkService) {
        self.networkService = networkService
    }

    func getFeedbacks(paginator: FeedbackEndpoint.FeedbackPaginator) async throws -> FeedbackPageResultDTO {
        let endpoint = FeedbackEndpoint.getFeedbacks(paginator)
        
        do {
            let token = try await networkService.execute(endpoint, expecting: FeedbackPageResultDTO.self)
            return token
        } catch {
            throw error
        }
    }

    func addFeedback(review: FeedbackEndpoint.FeedbackReview) async throws -> FeedbackDTO {
        let endpoint = FeedbackEndpoint.sendFeedback(review)
        
        do {
            let token = try await networkService.execute(endpoint, expecting: FeedbackDTO.self)
            return token
        } catch {
            throw error
        }
    }
}
