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
        
        // Debug: print the response
        printResponse(url: url, statusCode: response.response?.statusCode, data: data)
        
        return data
    }
    
    // MARK: - Debug Helpers
    private func printResponse(url: String, statusCode: Int?, data: Data) {
        print("╔══════════════════════════════════════════════════════════════")
        print("║ 📡 API RESPONSE")
        print("╠══════════════════════════════════════════════════════════════")
        print("║ URL: \(url)")
        print("║ Status Code: \(statusCode ?? -1)")
        print("╠══════════════════════════════════════════════════════════════")
        print("║ Response Body:")
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            prettyString.split(separator: "\n").forEach { line in
                print("║ \(line)")
            }
        } else if let rawString = String(data: data, encoding: .utf8) {
            print("║ \(rawString)")
        } else {
            print("║ [Unable to decode response data]")
        }
        
        print("╚══════════════════════════════════════════════════════════════")
    }
}
