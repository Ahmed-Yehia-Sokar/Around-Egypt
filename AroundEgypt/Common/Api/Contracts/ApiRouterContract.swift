//
//  ApiRouterContract.swift
//  AroundEgypt
//
//  Created by Admin on 22/01/2026.
//

import Foundation

protocol ApiRouterContract {
    var headers: [String: String] { get }
    var method: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
}

extension ApiRouterContract {
    var headers: [String: String] {
        [:]
    }
    var method: String {
        ""
    }
    var path: String {
        ""
    }
    var parameters: [String: Any] {
        [:]
    }
}
