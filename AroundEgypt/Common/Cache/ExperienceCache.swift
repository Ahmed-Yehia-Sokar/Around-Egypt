//
//  ExperienceCache.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import Foundation

class ExperienceCache {
    // MARK: - Keys
    private static let recommendedKey = "cached_recommended_experiences"
    private static let recentKey = "cached_recent_experiences"
    
    // MARK: - Recommended Experiences
    static func saveRecommended(_ experiences: [Experience]) {
        if let data = try? JSONEncoder().encode(experiences) {
            UserDefaults.standard.set(data, forKey: recommendedKey)
        }
    }
    
    static func loadRecommended() -> [Experience]? {
        guard let data = UserDefaults.standard.data(forKey: recommendedKey) else { return nil }
        return try? JSONDecoder().decode([Experience].self, from: data)
    }
    
    // MARK: - Recent Experiences
    static func saveRecent(_ experiences: [Experience]) {
        if let data = try? JSONEncoder().encode(experiences) {
            UserDefaults.standard.set(data, forKey: recentKey)
        }
    }
    
    static func loadRecent() -> [Experience]? {
        guard let data = UserDefaults.standard.data(forKey: recentKey) else { return nil }
        return try? JSONDecoder().decode([Experience].self, from: data)
    }
    
    // MARK: - Clear Cache
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: recommendedKey)
        UserDefaults.standard.removeObject(forKey: recentKey)
    }
}
