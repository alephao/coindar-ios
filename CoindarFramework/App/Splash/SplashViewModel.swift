// Copyright © lalacode.io All rights reserved.

import Foundation
import RxSwift
import RxCocoa
import Overture
import CoindarAPI

struct SplashViewModel {

    let progress: Driver<Float>
    let error: Observable<Error>
    let finishedLoading: Observable<AppState>

    init() {
        let coinsSink = Current.coindar.rx.getCoinsSink()
        let tagsSink = Current.coindar.rx.getTagsSink()

        progress = Observable.combineLatest(coinsSink.progress, tagsSink.progress, resultSelector: +)
            .map(Float.init)
            .asDriver(onErrorJustReturn: 0)

        error = Observable.merge(coinsSink.failure, tagsSink.failure)

        finishedLoading = Observable.zip(coinsSink.success, tagsSink.success) { coins, tags in
            AppState(coins: coins, tags: tags)
        }
    }
}
