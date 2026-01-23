//
//  ApiException.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

struct ApiException: LocalizedError {
    // MARK: - properties
    let statusCode: ApiStatusCode
    
    // MARK: - init method
    init(statusCode: ApiStatusCode) {
        self.statusCode = statusCode
    }
    
    // MARK: - LocalizedError
    var errorDescription: String? {
        return statusCode.description
    }
}
