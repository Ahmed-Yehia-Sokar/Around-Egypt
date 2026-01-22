//
//  ListExperiencesUsecase.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

struct ListExperiencesUsecaseProvider {
    static func provide() -> ListExperiencesUsecaseContract {
        let services = ListExperiencesServicesProvider.provide()
        return ListExperiencesUsecase(services: services)
    }
}

struct ListExperiencesUsecase: ListExperiencesUsecaseContract {
    // MARK: - properties
    private let services: ListExperiencesServicesContract
    
    // MARK: - init method
    init(services: ListExperiencesServicesContract) {
        self.services = services
    }
    
    // MARK: - methods
    func fetchRecommendedExperiences() async -> Result<[Experience], Error> {
        await services.fetchRecommendedExperiences()
    }
    
    func fetchRecentExperiences() async -> Result<[Experience], Error> {
        await services.fetchRecentExperiences()
    }
    
    func searchExperiences(query: String) async -> Result<[Experience], Error> {
        await services.searchExperiences(query: query)
    }
}
