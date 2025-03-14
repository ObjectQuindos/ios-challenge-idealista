//
//  RealStateTask.swift
//  IdealistaChallenge
//

import InfraLayerSDK

enum RealStateTask {
    case list
    case detail
}

extension RealStateTask: APITask {
    
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
