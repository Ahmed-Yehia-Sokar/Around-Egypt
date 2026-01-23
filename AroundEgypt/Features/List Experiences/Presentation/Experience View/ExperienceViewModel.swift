//
//  ExperienceViewModel.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation
import Combine

class ExperienceViewModelProvider {
    static func provide(experience: Experience) -> ExperienceViewModel {
        let usecase = ExperienceDetailsUsecaseProvider.provide()
        return ExperienceViewModel(experience: experience,
                                   usecase: usecase)
    }
}

class ExperienceViewModel: ObservableObject {
    // MARK: - published properties
    @Published var experience: Experience
    
    // MARK: - private properties
    private var usecase: ExperienceDetailsUsecaseContract

    // MARK: - init method
    init(experience: Experience,
         usecase: ExperienceDetailsUsecaseContract) {
        self.experience = experience
        self.usecase = usecase
    }
    
    // MARK: - methods
    func getExperienceCoverPhotoURL() -> URL? {
        guard let coverPhotoURL = URL(string: experience.coverPhoto) else { return nil }
        return coverPhotoURL
    }
    
    func getExperienceViewsNumber() -> String {
        "\(experience.viewsNumber)"
    }
    
    func getExperienceTitle() -> String {
        experience.title
    }
    
    func getExperienceLikesNumber() -> String {
        "\(experience.likesNumber)"
    }
    
    func isExperienceLiked() -> Bool {
        return experience.isLiked ?? false
    }
    
    func likeExperience() {
        Task {
            let result = await usecase.likeExperience(id: experience.id)
            switch result {
            case .success(let newLikesCount):
                experience.isLiked = true
                experience.likesNumber = newLikesCount
                ExperienceStore.shared.update(experience)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
