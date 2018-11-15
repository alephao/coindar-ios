import PlaygroundSupport
import UIKit
import CoindarAPI
import CoindarFramework
import Overture
import CoindarMocks

GlobalState.coins = .mock

let viewController = CoinsViewController()

PlaygroundPage.current.liveView = viewController
