//
//  APIClientMock.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

@testable import IdealistaChallenge
import Foundation
import InfraLayerSDK

class MockAPIClient: APIClientProtocol {
    
    var mockDataResponse: Data?
    var mockError: Error?
    var lastRequestedTask: APITask?
    
    func requestDataResponse<T: APITask>(_ task: T) async throws -> Data {
        lastRequestedTask = task
        
        if let error = mockError {
            throw error
        }
        
        guard let data = mockDataResponse else {
            throw NSError(domain: "test.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock data"])
        }
        
        return data
    }
    
    func requestJSONResponse<T: APITask>(_ task: T) async throws -> JSON {
        lastRequestedTask = task
        
        if let error = mockError {
            throw error
        }
        
        return [:]
    }
}

extension RealEStateTask {
    
    var path: String {
        
        switch self {
            
        case .list:
            return "/api/properties"
            
        case .detail:
            return "/api/properties/property001"
        }
    }
}
