// Copyright © lalacode.io All rights reserved.

import CoindarAPI

private let mockURL = URL(string: "https://coindar.org/images/coins/bitcoin/32x32.png")!

func coinWith(name: String) -> Coin {
    let coin = Coin.mock
    return Coin(id: coin.id, name: name, symbol: coin.symbol, image32: coin.image32, image64: coin.image64)
}

extension Coin {
    public static let mock = Coin(id: "btc", name: "Bitcoin", symbol: "BTC", image32: mockURL, image64: mockURL)
}

extension Array where Element == Coin {
    public static let mock: [Coin] = [
        .mock,
        coinWith(name: "Ethereum"),
        coinWith(name: "Tenzorum"),
        coinWith(name: "Litecoin"),
        coinWith(name: "EOS"),
        coinWith(name: "Ripple"),
        ]
}
