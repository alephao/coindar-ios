import PlaygroundSupport
import CoindarAPI
import CoindarFramework
import CoindarMocks

GlobalState.coins = .mock

PlaygroundPage.current.liveView = coinsViewController
