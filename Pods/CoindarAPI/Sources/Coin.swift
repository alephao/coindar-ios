//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct Coin: Decodable {
    public let id: String
    public let name: String
    public let symbol: String
    public let image32: URL
    public let image64: URL
}
