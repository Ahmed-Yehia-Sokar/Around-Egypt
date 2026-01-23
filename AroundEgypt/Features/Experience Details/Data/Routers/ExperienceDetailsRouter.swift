//
//  ExperienceDetailsRouter.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation

enum ExperienceDetailsRouter: ApiRouterContract {
    case likeExperience(id: String)
    
    var method: String {
        switch self {
        case .likeExperience:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .likeExperience(let id):
            return ApiConstants.baseUrl + "/api/v2/experiences/\(id)/like"
        }
    }
}
