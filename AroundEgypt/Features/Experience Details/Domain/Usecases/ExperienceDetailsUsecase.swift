//
//  ExperienceDetailsUsecase.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

struct ExperienceDetailsUsecaseProvider {
    static func provide() -> ExperienceDetailsUsecaseContract {
        let services = ExperienceDetailsServicesProvider.provide()
        return ExperienceDetailsUsecase(services: services)
    }
}

struct ExperienceDetailsUsecase: ExperienceDetailsUsecaseContract {
    // MARK: - properties
    private let services: ExperienceDetailsServicesContract
    
    // MARK: - init method
    init(services: ExperienceDetailsServicesContract) {
        self.services = services
    }
    
    // MARK: - methods
    func likeExperience(id: String) async -> Result<Int, Error> {
        await services.likeExperience(id: id)
    }
}
