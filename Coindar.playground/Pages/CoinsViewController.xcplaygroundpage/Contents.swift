import PlaygroundSupport
import UIKit
import CoindarAPI
import CoindarFramework
import Overture

let mockURL = URL(string: "https://coindar.org/images/coins/bitcoin/32x32.png")!

extension Coin {
    static let mock = Coin(id: "btc", name: "Bitcoin", symbol: "BTC", image32: mockURL, image64: mockURL)
}

func coinWith(name: String) -> Coin {
    let coin = Coin.mock
    return Coin(id: coin.id, name: name, symbol: coin.symbol, image32: coin.image32, image64: coin.image64)
}

extension Array where Element == Coin {
    static let mock: [Coin] = [
        .mock,
        coinWith(name: "Ethereum"),
        coinWith(name: "Tenzorum"),
        coinWith(name: "Litecoin"),
        coinWith(name: "EOS"),
        coinWith(name: "Ripple"),
    ]
}

GlobalState.coins = .mock

let viewController = CoinsViewController()

PlaygroundPage.current.liveView = viewController
