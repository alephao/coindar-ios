//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

extension JSONDecoder {
    static var snake: JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = .iso8601
        return d
    }
    
    static var events: JSONDecoder {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = DateDecodingStrategy.formatted(Event.EventDateFormatter.utc)
        return d
    }
}
