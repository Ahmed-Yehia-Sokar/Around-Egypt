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
        ExperienceViewModel(experience: experience)
    }
}

class ExperienceViewModel: ObservableObject {
    // MARK: - published properties
    @Published var experience: Experience
    
    // MARK: - init method
    init(experience: Experience) {
        self.experience = experience
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
}
