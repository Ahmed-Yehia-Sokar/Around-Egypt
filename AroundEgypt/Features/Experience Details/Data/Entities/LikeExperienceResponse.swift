//
//  LikeExperienceResponse.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

struct LikeExperienceResponse: Decodable {
    let likesNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case likesNumber = "likes_no"
    }
}
