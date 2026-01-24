//
//  ListExperiencesUsecaseTests.swift
//  AroundEgyptTests
//
//  Created by Admin on 24/01/2026.
//

import XCTest
@testable import AroundEgypt

// MARK: - Mock Services
final class MockListExperiencesServices: ListExperiencesServicesContract {
    var recommendedResult: Result<[Experience], Error> = .success([])
    var recentResult: Result<[Experience], Error> = .success([])
    var searchResult: Result<[Experience], Error> = .success([])
    var lastSearchQuery: String?
    
    func fetchRecommendedExperiences() async -> Result<[Experience], Error> {
        recommendedResult
    }
    
    func fetchRecentExperiences() async -> Result<[Experience], Error> {
        recentResult
    }
    
    func searchExperiences(query: String) async -> Result<[Experience], Error> {
        lastSearchQuery = query
        return searchResult
    }
}

// MARK: - Tests
final class ListExperiencesUsecaseTests: XCTestCase {
    
    private var sut: ListExperiencesUsecase!
    private var mockServices: MockListExperiencesServices!
    
    override func setUp() {
        super.setUp()
        mockServices = MockListExperiencesServices()
        sut = ListExperiencesUsecase(services: mockServices)
    }
    
    override func tearDown() {
        sut = nil
        mockServices = nil
        super.tearDown()
    }
    
    private func makeExperience(id: String = "1", title: String = "Test") -> Experience {
        Experience(
            id: id,
            title: title,
            coverPhoto: "",
            description: "",
            viewsNumber: 0,
            likesNumber: 0,
            recommended: 0,
            detailedDescription: "",
            address: "",
            isLiked: nil
        )
    }
    
    // MARK: - Fetch Recommended
    func test_fetchRecommendedExperiences_success() async {
        mockServices.recommendedResult = .success([makeExperience(id: "1")])
        
        let result = await sut.fetchRecommendedExperiences()
        
        if case .success(let experiences) = result {
            XCTAssertEqual(experiences.count, 1)
        } else {
            XCTFail("Expected success")
        }
    }
    
    func test_fetchRecommendedExperiences_failure() async {
        mockServices.recommendedResult = .failure(NSError(domain: "", code: 0))
        
        let result = await sut.fetchRecommendedExperiences()
        
        if case .success = result {
            XCTFail("Expected failure")
        }
    }
    
    // MARK: - Fetch Recent
    func test_fetchRecentExperiences_success() async {
        mockServices.recentResult = .success([makeExperience(id: "2")])
        
        let result = await sut.fetchRecentExperiences()
        
        if case .success(let experiences) = result {
            XCTAssertEqual(experiences.count, 1)
        } else {
            XCTFail("Expected success")
        }
    }
    
    func test_fetchRecentExperiences_failure() async {
        mockServices.recentResult = .failure(NSError(domain: "", code: 0))
        
        let result = await sut.fetchRecentExperiences()
        
        if case .success = result {
            XCTFail("Expected failure")
        }
    }
    
    // MARK: - Search
    func test_searchExperiences_success() async {
        mockServices.searchResult = .success([makeExperience(id: "3")])
        
        let result = await sut.searchExperiences(query: "test")
        
        if case .success(let experiences) = result {
            XCTAssertEqual(experiences.count, 1)
        } else {
            XCTFail("Expected success")
        }
    }
    
    func test_searchExperiences_failure() async {
        mockServices.searchResult = .failure(NSError(domain: "", code: 0))
        
        let result = await sut.searchExperiences(query: "test")
        
        if case .success = result {
            XCTFail("Expected failure")
        }
    }
}
