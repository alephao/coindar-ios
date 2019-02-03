// Copyright © lalacode.io All rights reserved.

import CoindarAPI

struct EventViewModel {
    private let event: CoindarAPI.Event
    private let coin: Coin

    // Coin
    var coinName: String { return coin.name }
    var coinSymbol: String { return coin.symbol }
    var coinImageUrl: URL { return coin.image64 }

    // Event
    var title: String { return event.caption }

    public init(event: CoindarAPI.Event, coin: Coin) {
        self.event = event
        self.coin = coin
    }
}
