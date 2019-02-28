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
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let e = UINavigationController()
        e.isNavigationBarHidden = true
        return e
    }()

    public var childCoordinators: [Coordinator] = []
    private let disposeBag = DisposeBag()

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        startSplashScene()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator {
    private func startSplashScene() {
        let splashViewController = SplashViewController()
        splashViewController.finishedLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: goToEvents)
            .disposed(by: disposeBag)
        navigationController.addChild(splashViewController)
    }

    private func goToEvents(with appState: AppState) {
        let viewController = EventsViewController(appState: appState)
        let nav = UINavigationController(rootViewController: viewController)
        navigationController.present(nav, animated: true, completion: nil)
    }

    private func goToCoins(with appState: AppState) {
        let viewController = CoinsViewController(appState: appState)
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
