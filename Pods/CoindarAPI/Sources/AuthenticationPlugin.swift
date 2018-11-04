//  Copyright © 2018 Aleph Retamal. All rights reserved./

import Foundation
import Moya

struct AuthPlugin: PluginType {
    let token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = request
        let accessTokenQueryItem = URLQueryItem(name: "access_token", value: token)
        guard let url = req.url?.withQueryItem(accessTokenQueryItem) else { return request }
        req.url = url
        return req
    }
}
