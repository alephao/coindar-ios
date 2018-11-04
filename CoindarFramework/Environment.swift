// Copyright © lalacode.io All rights reserved.

import Foundation
import CoindarAPI

public struct Environment {
    public var coindarApi = CoindarAPI(token: "")
}

public let Current = Environment()
