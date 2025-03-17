//
//  RealStateTask.swift
//  IdealistaChallenge
//

import InfraLayerSDK

enum RealEStateTask {
    case list
    case detail
}

extension RealEStateTask: APITask {
    
    var path: String {
        
        switch self {
            
        case .list:
            return "list.json"
            
        case .detail:
            return "detail.json"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .list, .detail:
            return .get
        }
    }
}
