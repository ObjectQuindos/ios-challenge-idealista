//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import XCTest
@testable import IdealistaChallenge

final class RealStateServiceTests: XCTestCase {
    
    var service: RealStateService!
    var mockClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        
        mockClient = MockAPIClient()
        service = RealStateService(client: mockClient)
    }
    
    override func tearDown() {
        service = nil
        mockClient = nil
        super.tearDown()
    }
    
    func testListRealEState_Success() async throws {
        
        let realEstatesArray = [RealEstate.realEstate1, RealEstate.realEstate2, RealEstate.realEstate3]
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        let mockData = try encoder.encode(realEstatesArray)
        
        mockClient.mockDataResponse = mockData
        
        let result = try await service.listRealEState()
        
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result.first?.propertyCode, "property001")
        XCTAssertEqual(mockClient.lastRequestedTask?.path, "list.json")
    }
    
    func testListRealEState_RequestFailure() async {
        
        let expectedError = NSError(domain: "network.error", code: 500, userInfo: nil)
        mockClient.mockError = expectedError
        
        do {
            _ = try await service.listRealEState()
            XCTFail("Expected error to be thrown")
            
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
    
    func testListRealEState_DecodingFailure() async {
        
        let invalidData = Data("invalid json".utf8)
        mockClient.mockDataResponse = invalidData
        
        do {
            _ = try await service.listRealEState()
            XCTFail("Expected error to be thrown")
            
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func testDetailRealEState_Success() async throws {
        
        let mockDetail = RealEstateDetail.realEstateDetail1
        let mockData = Converter.convertRealEstateDetailToData(mockDetail)
        mockClient.mockDataResponse = mockData
        
        let result = try await service.detailRealEState()
        
        XCTAssertEqual(result.adid, mockDetail.adid)
        XCTAssertEqual(result.price, mockDetail.price)
        XCTAssertEqual(result.propertyType, mockDetail.propertyType)
        XCTAssertEqual(result.propertyComment, mockDetail.propertyComment)
        XCTAssertEqual(mockClient.lastRequestedTask?.path, "detail.json")
    }
    
    func testDetailRealEState_RequestFailure() async {
        
        let expectedError = NSError(domain: "network.error", code: 404, userInfo: nil)
        mockClient.mockError = expectedError
        
        do {
            _ = try await service.detailRealEState()
            XCTFail("Expected error to be thrown")
            
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
}
