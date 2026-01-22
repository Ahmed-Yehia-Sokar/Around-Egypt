//
//  ListExperiencesServices.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

struct ListExperiencesServicesProvider {
    static func provide() -> ListExperiencesServicesContract {
        let apiClient = ApiClient()
        return ListExperiencesServices(apiClient: apiClient)
    }
}

struct ListExperiencesServices: ListExperiencesServicesContract {
    // MARK: - properties
    private let apiClient: ApiClientContract
    
    // MARK: - init method
    init(apiClient: ApiClientContract) {
        self.apiClient = apiClient
    }
    
    // MARK: - methods
    func fetchRecommendedExperiences() async -> Result<[Experience], Error> {
        do {
            let endpoint = ListExperiencesRouter.recommendedExperiences
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let response = try JSONDecoder().decode(ExperiencesResponse.self, from: data)
            return .success(response.data)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchRecentExperiences() async -> Result<[Experience], any Error> {
        do {
            let endpoint = ListExperiencesRouter.recentExperiences
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let response = try JSONDecoder().decode(ExperiencesResponse.self, from: data)
            return .success(response.data)
        } catch {
            return .failure(error)
        }
    }
    
    func searchExperiences(query: String) async -> Result<[Experience], Error> {
        do {
            let endpoint = ListExperiencesRouter.searchExperiences(query: query)
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let response = try JSONDecoder().decode(ExperiencesResponse.self, from: data)
            return .success(response.data)
        } catch {
            return .failure(error)
        }
    }
}
