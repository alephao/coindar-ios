// Copyright © lalacode.io All rights reserved.

import UIKit
import RxSwift
import CoindarAPI

public struct AppState {
    public var coins: [CoindarAPI.Coin] = []
    public var tags: [CoindarAPI.Tag] = []
}

public var GlobalState = AppState(coins: [], tags: [])

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

    func bind(gotoCoinsObservable: Observable<Void>) {
        gotoCoinsObservable
            .observeOn(MainScheduler.instance)
            .bind(onNext: gotoCoins)
            .disposed(by: disposeBag)
    }

    private func gotoCoins() {
        navigationController.present(coinsViewController, animated: true, completion: nil)
    }
}
