//
//  ExperienceDetailsServicesContract.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

protocol ExperienceDetailsServicesContract {
    func likeExperience(id: String) async -> Result<Int, Error>
}
