// Copyright © lalacode.io All rights reserved.

import RxSwift
import CoindarAPI

public struct AppState {
    public let coins: [CoindarAPI.Coin]
    public let tags: [CoindarAPI.Tag]
}
