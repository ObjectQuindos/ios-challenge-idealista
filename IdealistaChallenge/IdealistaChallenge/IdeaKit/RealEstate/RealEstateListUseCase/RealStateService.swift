//
//  RealStateServie.swift
//  IdealistaChallenge
//

import InfraLayerSDK

protocol RealStateServicing {
    func listRealEState() async throws -> [RealEstate]
    func detailRealEState() async throws -> RealEstateDetail
}

class RealStateService: Service {
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    func listRealEState() async throws -> [RealEstate] {
        
        let task = RealEStateTask.list
        
        do {
            dataResponse = try await client.requestDataResponse(task)
            
        } catch { throw error }
        
        do {
            return try decode([RealEstate].self, responseData: dataResponse)
            
        } catch { throw error }
    }
    
    func detailRealEState() async throws -> RealEstateDetail {
        
        let task = RealEStateTask.detail
        
        do {
            dataResponse = try await client.requestDataResponse(task)
            
        } catch { throw error }
        
        do {
            return try decode(RealEstateDetail.self, responseData: dataResponse)
            
        } catch { throw error }
    }
}
