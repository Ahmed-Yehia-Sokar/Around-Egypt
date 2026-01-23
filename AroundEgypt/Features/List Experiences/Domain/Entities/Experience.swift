//
//  Experience.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

struct ExperiencesResponse: Codable {
    let data: [Experience]
}

struct Experience: Codable, Identifiable {
    let id: String
    let title: String
    let coverPhoto: String
    let description: String
    let viewsNumber: Int
    var likesNumber: Int
    let recommended: Int
    let detailedDescription: String
    let address: String
    var isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverPhoto = "cover_photo"
        case description
        case viewsNumber = "views_no"
        case likesNumber = "likes_no"
        case recommended
        case detailedDescription = "detailed_description"
        case address
        case isLiked = "is_liked"
    }
}
