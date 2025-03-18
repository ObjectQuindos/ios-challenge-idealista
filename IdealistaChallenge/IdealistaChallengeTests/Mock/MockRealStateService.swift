//
//  IdealistaChallengeTests.swift
//  IdealistaChallengeTests
//
//  Created by David López on 13/3/25.
//

@testable import IdealistaChallenge
import Foundation
import InfraLayerSDK

class MockRealStateService: RealStateService {
    
    var mockListRealEstateResult: Swift.Result<[RealEstate], Error>?
    var mockDetailRealEstateResult: Swift.Result<RealEstateDetail, Error>?
    
    init() {
        super.init(client: MockAPIClient())
        
    }
    override func listRealEState() async throws -> [RealEstate] {
        
        guard let result = mockListRealEstateResult else {
            fatalError("mockListRealEstateResult not set")
        }
        
        switch result {
            
        case .success(let realEstates):
            return realEstates
        case .failure(let error):
            throw error
        }
    }
    
    override func detailRealEState() async throws -> RealEstateDetail {
        
        guard let result = mockDetailRealEstateResult else {
            fatalError("mockDetailRealEstateResult not set")
        }
        
        switch result {
            
        case .success(let detail):
            return detail
        case .failure(let error):
            throw error
        }
    }
}
