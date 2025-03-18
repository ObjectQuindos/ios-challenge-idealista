//
//  RealStateInteractor.swift
//  IdealistaChallenge
//

import Foundation

class RealEStateInteractor {
    
    private let service: RealStateService
    
    init(service: RealStateService? = nil) {
        let initService = service ?? RealStateService(client: APIClient(configuration: APIConfiguration.shared))
        self.service = initService
    }
    
    func listRealEState() async throws -> [RealEstate] {
        try await service.listRealEState()
    }
    
    func detailRealEstate() async throws -> RealEstateDetail {
        try await service.detailRealEState()
    }
}
