//
//  ListExperiencesRouter.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

enum ListExperiencesRouter: ApiRouterContract {
    case recommendedExperiences
    case recentExperiences
    case searchExperiences(query: String)
    
    var method: String {
        "GET"
    }
    
    var path: String {
        switch self {
        case .recommendedExperiences:
            return ApiConstants.baseUrl + "/api/v2/experiences?filter[recommended]=true"
        case .recentExperiences:
            return ApiConstants.baseUrl + "/api/v2/experiences"
        case .searchExperiences(let query):
            return ApiConstants.baseUrl + "/api/v2/experiences?filter[title]=\(query)"
        }
    }
}
