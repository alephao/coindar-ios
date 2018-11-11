// Copyright © lalacode.io All rights reserved.

import Foundation
import CoindarAPI

public struct Environment {
    public var coindar = Coindar(token: Config.coindarApiToken)
    public var userDefaults = UserDefaults.standard
}

public let Current = Environment()
