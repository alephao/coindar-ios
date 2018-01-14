import CoindarFoundation

enum NetworkingError: Error {
    
    enum Client: Int, Error {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case timeout = 408
        
        var localizedDescription: String {
            switch self {
            case .badRequest, .unauthorized, .forbidden, .notFound:
                return "Failed to connect to Coindar API, you might need to update the app"
            case .timeout:
                return "Timed out when trying to connect to the server, try again"
            }
        }
    }
    
    enum Server: Int, Error {
        case `internal` = 500
        case notImplemented = 501
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        
        var localizedDescription: String {
            switch self {
            case .internal, .notImplemented:
                return "Failed to connect to Coindar API, you might need to update the app"
            case .badGateway:
                return "Bad gateway, try again later"
            case .serviceUnavailable:
                return "The service is currently unavailable, try again later"
            case .gatewayTimeout:
                return "Gateway timed out, try again"
            }
        }
    }
}

class NetworkingErrorMatcher: ErrorMatcher {
    func matches(_ error: Error) -> Bool {
        return error is NetworkingError ||
            error is NetworkingError.Client ||
            error is NetworkingError.Server
    }
}
