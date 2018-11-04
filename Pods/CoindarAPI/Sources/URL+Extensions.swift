//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

enum UrlBuildingError: Swift.Error {
    case failedToAddQueryItem
}

extension URL {
    func withQueryItem(_ queryItem: URLQueryItem) -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = [queryItem]
        } else {
            urlComponents.queryItems?.append(queryItem)
        }

        return urlComponents.url
    }
}
