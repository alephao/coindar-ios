import PlaygroundSupport
import UIKit
import CoindarAPI
import CoindarFramework
import Overture
import CoindarMocks
import RxSwift

extension AppState {
    static var mock: AppState {
        return AppState(coins: .mock, tags: .mock)
    }
}

let coordinator = AppCoordinator(window: UIWindow())

let viewController = CoinsViewController(appState: .mock, coordinator: coordinator)

PlaygroundPage.current.liveView = viewController
