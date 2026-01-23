//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation
import Combine

class HomeViewModelProvider {
    static func provide() -> HomeViewModel {
        let usecase = ListExperiencesUsecaseProvider.provide()
        return HomeViewModel(usecase: usecase)
    }
}

class HomeViewModel: ObservableObject {
    // MARK: - published properties
    @Published var searchQuery = ""
    @Published var recommendedExperiences: [Experience] = []
    @Published var recentExperiences: [Experience] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - private properties
    private let usecase: ListExperiencesUsecaseContract
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init method
    init(usecase: ListExperiencesUsecaseContract) {
        self.usecase = usecase
        setupSearchDebounce()
    }
    
    // MARK: - private methods
    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task { [weak self] in
                    await self?.searchExperiences(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - methods
    func fetchExperiences() async {
        isLoading = true
        errorMessage = nil
        
        async let recommendedResult = usecase.fetchRecommendedExperiences()
        async let recentResult = usecase.fetchRecentExperiences()
        let (recommended, recent) = await (recommendedResult, recentResult)
        
        switch recommended {
        case .success(let experiences):
            recommendedExperiences = experiences
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
        
        switch recent {
        case .success(let experiences):
            recentExperiences = experiences
        case .failure(let error):
            if errorMessage == nil {
                errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
    func searchExperiences(query: String) async {
        guard !query.isEmpty else {
            await fetchExperiences()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let result = await usecase.searchExperiences(query: query)
        
        switch result {
        case .success(let experiences):
            recommendedExperiences = []
            recentExperiences = experiences
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
