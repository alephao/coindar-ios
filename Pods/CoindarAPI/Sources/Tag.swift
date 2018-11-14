//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct Tag {
    public let id: String
    public let name: String

    public init(id: String,
                name: String) {
        self.id = id
        self.name = name
    }
}

extension Tag: Decodable { }
