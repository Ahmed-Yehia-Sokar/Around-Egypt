//
//  ListExperiencesServicesContract.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

protocol ListExperiencesServicesContract {
    func fetchRecommendedExperiences() async -> Result<[Experience], Error>
    func fetchRecentExperiences() async -> Result<[Experience], Error>
    func searchExperiences(query: String) async -> Result<[Experience], Error>
}
