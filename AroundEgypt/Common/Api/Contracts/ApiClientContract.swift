//
//  ApiClientContract.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

protocol ApiClientContract {
    func performRequest<E: ApiRouterContract>(endpoint: E) async throws -> Data
}
