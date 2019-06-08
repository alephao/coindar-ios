// Copyright © lalacode.io All rights reserved.

import RxSwift
import CoindarAPI

struct AppState {
    let coins: [CoindarAPI.Coin]
    let tags: [CoindarAPI.Tag]
}
