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

    func getFeedbacks(paginator: FeedbackEndpoint.FeedbackPaginator, isPlace: Bool) async throws -> FeedbackPageResultDTO {
        let endpoint = FeedbackEndpoint.getFeedbacks(paginator, isPlace: isPlace)
        
        do {
            let page = try await networkService.execute(endpoint, expecting: FeedbackPageResultDTO.self)
            return page
        } catch {
            throw error
        }
    }

    func addFeedback(review: FeedbackEndpoint.FeedbackReview, isPlace: Bool) async throws {
        let endpoint = FeedbackEndpoint.sendFeedback(review, isPlace: isPlace)
        
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

    func getAllFeedback() async throws -> [UserFeedback] {
        let endpoint = FeedbackEndpoint.getAllFeedback
        
        do {
            let feedback = try await networkService.execute(endpoint, expecting: [UserFeedbackDTO].self)
            return feedback.map { $0.asDomain() }
        } catch {
            throw error
        }
    }
}
