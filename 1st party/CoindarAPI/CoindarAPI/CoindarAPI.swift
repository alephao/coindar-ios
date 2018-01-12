import CoindarFoundation

public enum CoindarAPI {
    case lastEvents(limit: Int?)
    case coinEvents(coinName: String)
    case events(year: Int, month: Int, day: Int?)
}

extension CoindarAPI: API {
    public var baseURL: URL {
        return URL(string: "https://coindar.org/api/v1")!
    }
    
    public var path: URL {
        switch self {
        case .lastEvents: return baseURL.appendingPathComponent("lastEvents")
        case .coinEvents: return baseURL.appendingPathComponent("coinEvents")
        case .events: return baseURL.appendingPathComponent("events")
        }
    }
    
    public var params: [String : String]? {
        switch self {
        case .lastEvents(let limit):
            if let limit = limit {
                return ["limit": String(limit)]
            } else {
                return nil
            }
        case .coinEvents(let coinName):
            return ["name": coinName]
        case .events(let year, let month, let day):
            var parameters: [String: String] = ["year": String(year),
                                                "month": String(month)]
            if let day = day {
                parameters["day"] = String(day)
            }
            return parameters
        }
    }
}

