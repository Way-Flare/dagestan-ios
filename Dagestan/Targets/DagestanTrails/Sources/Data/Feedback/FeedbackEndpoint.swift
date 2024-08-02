//
//  ReviewEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

enum FeedbackEndpoint: ApiEndpoint {
    case getFeedbacks(FeedbackPaginator, isPlace: Bool)
    case sendFeedback(FeedbackReview, isPlace: Bool)
    case getAllFeedback
    
    var path: String {
        switch self {
            case .getAllFeedback:
                return "profile/feedbacks"
            case let .getFeedbacks(feedbackPaginator, isPlace):
                return "\(isPlace ? "places" : "routes")/\(feedbackPaginator.id)/feedbacks/"
            case let .sendFeedback(feedbackReview, isPlace):
                return "\(isPlace ? "places" : "routes")/\(feedbackReview.id)/feedbacks/"
        }
    }
    
    var method: CoreKit.Method {
        switch self {
            case .getFeedbacks, .getAllFeedback:
                return .get
            case .sendFeedback:
                return .post
        }
    }
    
    var headers: Headers? {
        nil
    }
    
    var multipartFormData: [MultipartFormData]? {
        switch self {
            case let .sendFeedback(feedbackReview, _):
                var formData = [MultipartFormData]()

                if let comment = feedbackReview.comment,
                   let commentData = comment.data(using: .utf8)
                {
                    formData.append(MultipartFormData(data: commentData, name: "comment"))
                    print("Comment data added")
                }
                
                let starsData = "\(feedbackReview.stars)".data(using: .utf8)!
                formData.append(MultipartFormData(data: starsData, name: "stars"))
                print("Stars data added")
                
                for (index, imageData) in feedbackReview.images.enumerated() {
                    let imagePart = MultipartFormData(data: imageData, name: "images", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                    formData.append(imagePart)
                    print("Added image \(index)")
                }

                print("Total parts: \(formData.count)")
                return formData
                
            default:
                print("No multipart data available")
                return nil
        }
    }
}

extension FeedbackEndpoint {
    public struct FeedbackPaginator: Encodable {
        public let id: Int
        public let page_size: Int
        public let pages: Int
        
        public init(
            id: Int,
            page_size: Int,
            pages: Int
        ) {
            self.id = id
            self.page_size = page_size
            self.pages = pages
        }
    }
    
    public struct FeedbackReview {
        public let id: Int
        public let stars: Int
        public let comment: String?
        public let images: [Data]
        
        public init(
            id: Int,
            stars: Int,
            comment: String?,
            images: [Data]
        ) {
            self.id = id
            self.stars = stars
            self.comment = comment
            self.images = images
        }
    }
}
