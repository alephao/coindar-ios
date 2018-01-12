import Foundation

class ServiceProvider {
    static let shared = ServiceProvider()
    
    let networking: Networking = .init()
    lazy var coindarService: CoindarService = .init(provider: self)
}
