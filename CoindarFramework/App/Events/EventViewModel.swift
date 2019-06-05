// Copyright © lalacode.io All rights reserved.

import CoindarAPI

struct EventViewModel {
    private let event: CoindarAPI.Event
    private let coin: Coin
    private let tag: Tag

    let id = UUID().uuidString

    // Coin
    var coinName: String { return coin.name }
    var coinSymbol: String { return coin.symbol }
    var coinImageUrl: URL { return coin.image64 }

    // Tag
    var tagName: String { return tag.name }
    var tagStyle: TagStyle { return Int(tag.id).flatMap (TagStyle.init) ?? .unknown }

    // Event
    var title: String { return event.caption }
    var startingDate: String { return formatStartingDate(event.dateStart) }

    public init(event: CoindarAPI.Event, coin: Coin, tag: Tag) {
        self.event = event
        self.coin = coin
        self.tag = tag
    }
}

private let dateFormatter: DateFormatter = {
    let e = DateFormatter()
    e.dateFormat = "dd MMM yyyy"
    return e
}()

private func formatStartingDate(_ date: Date) -> String {
    return dateFormatter.string(from: date)
}
