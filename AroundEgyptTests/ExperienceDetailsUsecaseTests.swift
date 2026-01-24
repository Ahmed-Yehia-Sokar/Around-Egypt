//
//  ExperienceDetailsUsecaseTests.swift
//  AroundEgyptTests
//
//  Created by Admin on 24/01/2026.
//

import XCTest
@testable import AroundEgypt

// MARK: - Mock Services
final class MockExperienceDetailsServices: ExperienceDetailsServicesContract {
    var likeResult: Result<Int, Error> = .success(0)
    
    func likeExperience(id: String) async -> Result<Int, Error> {
        likeResult
    }
}

// MARK: - Tests
final class ExperienceDetailsUsecaseTests: XCTestCase {
    
    private var sut: ExperienceDetailsUsecase!
    private var mockServices: MockExperienceDetailsServices!
    
    override func setUp() {
        super.setUp()
        mockServices = MockExperienceDetailsServices()
        sut = ExperienceDetailsUsecase(services: mockServices)
    }
    
    override func tearDown() {
        sut = nil
        mockServices = nil
        super.tearDown()
    }
    
    // MARK: - Like Experience
    func test_likeExperience_success() async {
        mockServices.likeResult = .success(10)
        
        let result = await sut.likeExperience(id: "1")
        
        if case .success(let likesCount) = result {
            XCTAssertEqual(likesCount, 10)
        } else {
            XCTFail("Expected success")
        }
    }
    
    func test_likeExperience_failure() async {
        mockServices.likeResult = .failure(NSError(domain: "", code: 0))
        
        let result = await sut.likeExperience(id: "1")
        
        if case .success = result {
            XCTFail("Expected failure")
        }
    }
}
