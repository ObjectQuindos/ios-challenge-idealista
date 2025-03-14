//
//  RealStateInteractor.swift
//  IdealistaChallenge
//

import Foundation

final class RealStateInteractor {
    
    private let service: RealStateService
    
    init(service: RealStateService? = nil) {
        let initService = service ?? RealStateService(client: APIClient(configuration: APIConfiguration.shared))
        self.service = initService
    }
    
    func listRealState() async throws -> [RealEstate] {
        try await service.listRealState()
    }
    
    func detailRealState() async throws -> [RealEstate] {
        try await service.listRealState()
    }
}
