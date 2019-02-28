// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import CoindarAPI

struct CoinsViewModel {

    let coins: Driver<[CoindarAPI.Coin]>

    init(appState: AppState) {
        coins = Driver.just(appState.coins)
    }

}
