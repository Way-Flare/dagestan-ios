//
//  IFeedbackService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import CoreKit

struct FeedbackPageResultDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [AccountDTO]
}

struct AccountDTO: Decodable {
    let id: Int
    let images: [ImageDTO]
    let user: UserDTO
    let stars: Int
    let comment: String?
    let createdAt: String
}

struct FeedbackDTO: Decodable {
    let stars: Int
    let comment: String?
    let images: [String]?
}

protocol IFeedbackService {
    func getFeedbacks(paginator: FeedbackEndpoint.FeedbackPaginator, isPlace: Bool) async throws -> FeedbackPageResultDTO 
    func addFeedback(review: FeedbackEndpoint.FeedbackReview, isPlace: Bool) async throws
    func getAllFeedback() async throws -> [UserFeedback]
}
