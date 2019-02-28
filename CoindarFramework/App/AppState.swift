// Copyright © lalacode.io All rights reserved.

import RxSwift
import CoindarAPI

public struct AppState {
    public let coins: Observable<[CoindarAPI.Coin]>
    public let tags: Observable<[CoindarAPI.Tag]>

    public init(coins: Observable<[CoindarAPI.Coin]>,
                tags: Observable<[CoindarAPI.Tag]>) {
        self.coins = coins
        self.tags = tags
    }
}
