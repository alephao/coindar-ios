//  Copyright © 2018 Lalacode. All rights reserved.

import Foundation

extension JSONEncoder {
    static var snake: JSONEncoder {
        let e = JSONEncoder()
        e.keyEncodingStrategy = .convertToSnakeCase
        return e
    }
}
