//
//  ApiStatusCode.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

enum ApiStatusCode: Int {
    case unknown = -1
    case noInternetConnection = -2
    
    // Success
    case ok = 200
    case created = 201
    case noContent = 204
    
    // Client Errors
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case conflict = 409
    case tooManyRequests = 429
    
    // Server Errors
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    
    var description: String {
        switch self {
            // Success
        case .ok:
            return "The request succeeded"
        case .created:
            return "A new resource was created successfully"
        case .noContent:
            return "The request succeeded, no content to return"
            
            // Client Errors
        case .badRequest:
            return "Bad request due to client error"
        case .unauthorized:
            return "Authentication required"
        case .forbidden:
            return "Access forbidden"
        case .notFound:
            return "Resource not found"
        case .methodNotAllowed:
            return "HTTP method not allowed"
        case .conflict:
            return "Request conflict with server state"
        case .tooManyRequests:
            return "Too many requests, rate limited"
            
            // Server Errors
        case .internalServerError:
            return "Internal server error"
        case .notImplemented:
            return "Server does not support this request"
        case .badGateway:
            return "Invalid response from upstream server"
        case .serviceUnavailable:
            return "Service temporarily unavailable"
        case .gatewayTimeout:
            return "Gateway timed out waiting for response"
            
            // No Internet Connection
        case .noInternetConnection:
            return "Check your internet connection"
            
        default:
            return "Oops! Something went wrong!"
        }
    }
}

