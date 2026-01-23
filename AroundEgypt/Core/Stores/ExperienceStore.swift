//
//  ExperienceStore.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation
import Combine

/// A shared store that manages Experience state across the app.
/// When an Experience is updated anywhere, subscribers are notified.
class ExperienceStore: ObservableObject {
    static let shared = ExperienceStore()
    
    /// Publisher that emits updated Experience objects
    let experienceUpdated = PassthroughSubject<Experience, Never>()
    
    private init() {}
    
    /// Call this method when an Experience is updated to notify all subscribers
    func update(_ experience: Experience) {
        experienceUpdated.send(experience)
    }
}
