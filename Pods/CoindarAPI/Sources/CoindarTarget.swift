//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Moya

enum CoindarTarget {
    case coins
    case tags
    case events(EventsParams)
    case social(coins: [String])
}

extension CoindarTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://coindar.org/api/v2")!
    }
    
    var path: String {
        switch self {
        case .coins: return "/coins"
        case .tags: return "/tags"
        case .events: return "/events"
        case .social: return "/social"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Moya.Task {
        switch self {
        case .coins: return .requestPlain
        case .tags: return .requestPlain
        case .events(let params):
            var parameters: [String: Any] = [:]
            if let page = params.page { parameters["page"] = page }
            if let pageSize = params.pageSize { parameters["page_size"] = pageSize }
            if let filterDateStart = params.filterDateStart { parameters["filter_date_start"] = Event.EventDateFormatter.noTime.string(from: filterDateStart) }
            if let filterDateEnd = params.filterDateEnd { parameters["filter_date_end"] = Event.EventDateFormatter.noTime.string(from: filterDateEnd) }
            if let filterCoins = params.filterCoins { parameters["filter_coins"] = filterCoins }
            if let filterTags = params.filterTags { parameters["filter_tags"] = filterTags }
            if let sortBy = params.sortBy { parameters["sort_by"] = sortBy.rawValue }
            if let orderBy = params.orderBy { parameters["order_by"] = orderBy.rawValue }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .social(let coins): return .requestParameters(parameters: ["coins": coins], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? { return nil }
    
    var sampleData: Data { return Data() }
}
