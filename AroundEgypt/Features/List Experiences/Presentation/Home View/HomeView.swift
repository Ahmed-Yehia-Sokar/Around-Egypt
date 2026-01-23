//
//  HomeView.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModelProvider.provide()
    
    var body: some View {
        ScrollView {
            VStack {
                searchTextField
                
                if !viewModel.recommendedExperiences.isEmpty {
                    recommendedExperiencesSection
                }
                
                if !viewModel.recentExperiences.isEmpty {
                    recentExperiencesSection
                }
            }
        }
    }
    
    // MARK: - private properties
    private var searchTextField: some View {
        TextField("Search experiences...", text: $viewModel.searchQuery)
            .textFieldStyle(.roundedBorder)
            .submitLabel(.search)
            .padding()
    }
    
    private var recommendedExperiencesSection: some View {
        VStack(alignment: .leading) {
            Text("Recommended Experiences")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.recommendedExperiences) { experience in
                        let experienceViewModel = ExperienceViewModelProvider.provide(experience: experience)
                        ExperienceView(viewModel: experienceViewModel)
                    }
                }
            }
        }
    }
    
    private var recentExperiencesSection: some View {
        VStack(alignment: .leading) {
            Text("Most Recent")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(viewModel.recentExperiences) { experience in
                let experienceViewModel = ExperienceViewModelProvider.provide(experience: experience)
                ExperienceView(viewModel: experienceViewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}
