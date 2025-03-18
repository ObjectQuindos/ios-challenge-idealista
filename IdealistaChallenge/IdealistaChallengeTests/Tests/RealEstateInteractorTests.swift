//
//  RealEstateInteractorTests.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import XCTest
@testable import IdealistaChallenge

final class RealStateInteractorTests: XCTestCase {
    
    var interactor: RealEStateInteractor!
    var mockService: MockRealStateService!
    
    override func setUp() {
        super.setUp()
        
        mockService = MockRealStateService()
        interactor = RealEStateInteractor(service: mockService)
    }
    
    override func tearDown() {
        interactor = nil
        mockService = nil
        
        super.tearDown()
    }
    
    func testListRealEState_Success() async throws {
        
        let expectedRealEstates = RealEstate.getMockRealEstates
        mockService.mockListRealEstateResult = .success(expectedRealEstates)
        
        let result = try await interactor.listRealEState()
        
        XCTAssertEqual(result.count, expectedRealEstates.count)
        XCTAssertEqual(result.first?.propertyCode, expectedRealEstates.first?.propertyCode)
    }
    
    func testListRealEState_Failure() async {
        
        let expectedError = NSError(domain: "test.error", code: 401, userInfo: nil)
        mockService.mockListRealEstateResult = .failure(expectedError)
        
        do {
            _ = try await interactor.listRealEState()
            XCTFail("Expected error to be thrown")
            
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
    
    func testDetailRealEstate_Success() async throws {
        
        let mockDetail = RealEstateDetail.realEstateDetail1
        mockService.mockDetailRealEstateResult = .success(mockDetail)
        
        let result = try await interactor.detailRealEstate()
        
        XCTAssertEqual(result.adid, mockDetail.adid)
        XCTAssertEqual(result.price, mockDetail.price)
        XCTAssertEqual(result.propertyComment, mockDetail.propertyComment)
        XCTAssertEqual(result.operation, mockDetail.operation)
        XCTAssertEqual(result.propertyType, mockDetail.propertyType)
    }
    
    func testDetailRealEstate_Failure() async {
        
        let expectedError = NSError(domain: "test.error", code: 404, userInfo: nil)
        mockService.mockDetailRealEstateResult = .failure(expectedError)
        
        do {
            _ = try await interactor.detailRealEstate()
            XCTFail("Expected error to be thrown")
            
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
}
