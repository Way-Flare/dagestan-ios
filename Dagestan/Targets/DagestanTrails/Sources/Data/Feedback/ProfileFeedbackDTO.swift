//
//  ProfileFeedbackDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct UserFeedbackDTO: Decodable {
    let id: Int
    let comment: String
    let createdAt: String
    let stars: Int
    let images: [ImageInUserFeedbackDTO]? // 5
    let type: FeedbackTypeDTO
    let content: UserContentFeedbackDTO
}

extension UserFeedbackDTO: Domainable {
    func asDomain() -> UserFeedback {
        UserFeedback(
            id: id,
            comment: comment,
            createdAt: createdAt,
            stars: stars,
            images: images?.compactMap { URL(string: $0.file) },
            type: type,
            content: content.asDomain()
        )
    }
}

enum FeedbackTypeDTO: String, Decodable {
    case place
    case route
}

struct ImageInUserFeedbackDTO: Decodable {
    let id: Int
    let file: String
}

struct UserContentFeedbackDTO: Decodable {
    let id: Int
    let mainTag: TagPlaceDTO?
    let title: String
    let images: [ImageInUserFeedbackDTO]?
}

extension UserContentFeedbackDTO: Domainable {
    func asDomain() -> UserContentFeedback {
        UserContentFeedback(
            id: id,
            mainTag: mainTag?.asDomain(),
            title: title,
            images: images?.compactMap { URL(string: $0.file) }
        )
    }
}

struct UserFeedback {
    let id: Int
    let comment: String
    let createdAt: String
    let stars: Int
    let images: [URL]?
    let type: FeedbackTypeDTO
    let content: UserContentFeedback
}

struct UserContentFeedback {
    let id: Int
    let mainTag: TagPlace?
    let title: String
    let images: [URL]?
}
