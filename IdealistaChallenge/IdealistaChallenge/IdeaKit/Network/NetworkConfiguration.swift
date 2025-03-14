
import Foundation
import InfraLayerSDK

struct AppConfiguration {
    
    let baseURL: String
    
    static var current: AppConfiguration {
        
        return AppConfiguration(
            baseURL: "https://idealista.github.io/ios-challenge"
        )
    }
}

class APIConfiguration {
    
    static let shared = APIConfiguration()
    
    static var baseURL: String {
        return AppConfiguration.current.baseURL
    }
    
    func makeClient() -> InfraLayer? {
        guard let url = URL(string: APIConfiguration.baseURL) else { return nil }
        return InfraLayer(with: url)
    }
}
