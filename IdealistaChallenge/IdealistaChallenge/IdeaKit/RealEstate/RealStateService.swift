//
//  RealStateServie.swift
//  IdealistaChallenge
//

import InfraLayerSDK

final class RealStateService: Service {
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    func listRealState() async throws -> [RealEstate] {
        
        let task = RealStateTask.list
        
        do {
            dataResponse = try await client.requestDataResponse(task)
            
        } catch { throw error }
        
        do {
            return try decode([RealEstate].self, responseData: dataResponse)
            
        } catch { throw error }
    }
}
