//
//  ApiClient.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation
import Alamofire

struct ApiClient: ApiClientContract {
    // MARK: - methods
    func performRequest<E: ApiRouterContract>(endpoint: E) async throws -> Data {
        let url = endpoint.path
        let method = HTTPMethod(rawValue: endpoint.method)
        let headers = HTTPHeaders(endpoint.headers)
        let response = await AF
            .request(
                url,
                method: method,
                parameters: endpoint.parameters,
                encoding: URLEncoding.default,
                headers: headers
            )
            .serializingData()
            .response
        
        // handle no internet connection
        if let error = response.error,
           error.isSessionTaskError {
            throw ApiException(statusCode: .noInternetConnection)
        }
        
        // handle HTTP status codes
        if let statusCode = response.response?.statusCode,
           !(200...299).contains(statusCode),
           let apiStatusCode = ApiStatusCode(rawValue: statusCode) {
            throw ApiException(statusCode: apiStatusCode)
        }
        
        // return response data or throw unknown error
        guard let data = response.data else {
            throw ApiException(statusCode: .unknown)
        }
        
        return data
    }
}
