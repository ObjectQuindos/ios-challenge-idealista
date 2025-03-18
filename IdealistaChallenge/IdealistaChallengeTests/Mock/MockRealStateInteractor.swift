//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 18/3/25.
//

import Foundation
@testable import IdealistaChallenge

class MockRealStateInteractor: RealEStateInteractor {
    
    var mockRealEstateResult: Result<[RealEstate], Error>?
    var mockDetailRealEstateResult: Result<RealEstateDetail, Error>?
    var addDelay = false
    
    init() {
        super.init(service: nil)
    }
    
    override func listRealEState() async throws -> [RealEstate] {
        
        guard let result = mockRealEstateResult else {
            fatalError("mockRealEstateResult not set")
        }
        
        switch result {
        case .success(let realEstates):
            return realEstates
        case .failure(let error):
            throw error
        }
    }
    
    override func detailRealEstate() async throws -> RealEstateDetail {
        
        if addDelay {
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 segundos de retraso
        }
        
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
