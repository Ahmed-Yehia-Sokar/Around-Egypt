//
//  ExperienceDetailsServices.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation

struct ExperienceDetailsServicesProvider {
    static func provide() -> ExperienceDetailsServicesContract {
        let apiClient = ApiClient()
        return ExperienceDetailsServices(apiClient: apiClient)
    }
}

struct ExperienceDetailsServices: ExperienceDetailsServicesContract {
    // MARK: - properties
    private let apiClient: ApiClientContract
    
    // MARK: - init method
    init(apiClient: ApiClientContract) {
        self.apiClient = apiClient
    }
    
    // MARK: - methods
    func likeExperience(id: String) async -> Result<Int, Error> {
        do {
            let endpoint = ExperienceDetailsRouter.likeExperience(id: id)
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let response = try JSONDecoder().decode(LikeExperienceResponse.self, from: data)
            return .success(response.likesNumber)
        } catch {
            return .failure(error)
        }
    }
}
