//
//  ApiException.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

struct ApiException: Error {
    // MARK: - properties
    let statusCode: ApiStatusCode,
        description: String
    
    // MARK: - init method
    init(statusCode: ApiStatusCode) {
        self.statusCode = statusCode
        self.description = statusCode.description
    }
}
