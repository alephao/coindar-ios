// Copyright © lalacode.io All rights reserved.

import UIKit
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

public class AppCoordinator: Coordinator {

    private let disposeBag = DisposeBag()

    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let e = UINavigationController()
        e.isNavigationBarHidden = true
        return e
    }()

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        navigationController.addChild(SplashViewController(coordinator: self))
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func gotoEvents(with appState: AppState) {
        let viewController = EventsViewController(appState: appState)
        let nav = UINavigationController(rootViewController: viewController)
        navigationController.present(nav, animated: true, completion: nil)
    }

    func gotoCoins(with appState: AppState) {
        let viewController = CoinsViewController(appState: appState, coordinator: self)
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
