// Copyright © lalacode.io All rights reserved.

import CoindarAPI

struct EventViewModel {
    private let event: CoindarAPI.Event
    private let coin: Coin
    private let tag: Tag

    // Coin
    var coinName: String { return coin.name }
    var coinSymbol: String { return coin.symbol }
    var coinImageUrl: URL { return coin.image64 }
    var tagName: String { return tag.name }
    var tagStyle: TagStyle { return Int(tag.id).flatMap(TagStyle.init) ?? .unknown }

    // Event
    var title: String { return event.caption }

    public init(event: CoindarAPI.Event, coin: Coin, tag: Tag) {
        self.event = event
        self.coin = coin
        self.tag = tag
    }
}
