//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct Coin {
    public let id: String
    public let name: String
    public let symbol: String
    public let image32: URL
    public let image64: URL

    public init(id: String,
                name: String,
                symbol: String,
                image32: URL,
                image64: URL) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image32 = image32
        self.image64 = image64
    }
}

extension Coin: Decodable { }
