//
//  ExperienceDetailsViewModel.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation
import Combine

class ExperienceDetailsViewModelProvider {
    static func provide(experience: Experience) -> ExperienceDetailsViewModel {
        let usecase = ExperienceDetailsUsecaseProvider.provide()
        return ExperienceDetailsViewModel(experience: experience,
                                          usecase: usecase)
    }
}

class ExperienceDetailsViewModel: ObservableObject {
    // MARK: - published properties
    @Published var experience: Experience
    
    // MARK: - private properties
    private var usecase: ExperienceDetailsUsecaseContract
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init method
    init(experience: Experience,
         usecase: ExperienceDetailsUsecaseContract) {
        self.experience = experience
        self.usecase = usecase
        subscribeToExperienceUpdates()
    }
    
    private func subscribeToExperienceUpdates() {
        ExperienceStore.shared.experienceUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedExperience in
                self?.experience = updatedExperience
            }
            .store(in: &cancellables)
    }
    
    // MARK: - methods
    func getExperienceCoverPhotoURL() -> URL? {
        URL(string: experience.coverPhoto)
    }
    
    func getExperienceViewsNumber() -> String {
        "\(experience.viewsNumber) views"
    }
    
    func getExperienceTitle() -> String {
        experience.title
    }
    
    func getExperienceAddress() -> String {
        experience.address
    }
    
    func getExperienceLikesNumber() -> String {
        "\(experience.likesNumber)"
    }
    
    func isExperienceLiked() -> Bool {
        experience.isLiked ?? false
    }
    
    func getExperienceDescription() -> String {
        experience.detailedDescription
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
