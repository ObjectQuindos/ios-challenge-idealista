//
//  NetworkConfiguration.swift
//  IdealistaChallenge
//

import Foundation
import InfraLayerSDK

protocol APIClientProtocol {
    func requestDataResponse<T: APITask>(_ task: T) async throws -> Data
    func requestJSONResponse<T: APITask>(_ task: T) async throws -> JSON
}

final class APIClient: APIClientProtocol {
    
    private let configuration: APIConfiguration
    private let client : InfraLayer? // Our session (URLSession)
    
    init(configuration: APIConfiguration) {
        self.configuration = configuration
        self.client = configuration.makeClient()
    }
    
    @discardableResult
    func requestDataResponse<T: APITask>(_ task: T) async throws -> Data {
        
        return try await withCheckedThrowingContinuation ( { (continuation: CheckedContinuation<Data, Error>) in
            
            client?.request(task) { (result: DataResponse) in
                
                switch result {
                    
                case .success(let data):
                    
                    if let data = data {
                        continuation.resume(returning: data)
                        
                    } else {
                        //continuation.resume(throwing: NetworkError.dataNotFound)
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    @discardableResult
    func requestJSONResponse<T: APITask>(_ task: T) async throws -> JSON {
        
        return try await withCheckedThrowingContinuation ( { (continuation: CheckedContinuation<JSON, Error>) in
            
            client?.request(task) { (result: JSONResponse) in
                
                switch result {
                    
                case .success(_):
                    continuation.resume(returning: [:])
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
