// Copyright © lalacode.io All rights reserved.

import Foundation
import RxSwift
import RxCocoa
import Overture
import CoindarAPI

enum GlobalState {
    static var coins: [CoindarAPI.Coin] = []
}

internal class SplashViewModel {

    private let disposeBag = DisposeBag()

    let progress: Driver<Float>

    private let _displayError: PublishSubject<Error> = .init()
    lazy var displayError: Observable<Error> = _displayError

    private let _finishedLoading: PublishSubject<Void> = .init()
    lazy var finishedLoading: Observable<Void> = _finishedLoading

    init() {

        let coins = Current.coindar.rx.getCoins().share()

        progress = coins
            .filter(Either.filterLeft)
            .map(pipe(Either.mapLeft, Float.init))
            .asDriver(onErrorJustReturn: 0)

        coins
            .filter(Either.filterRight)
            .map(Either.mapRight)
            .subscribe(onNext: { [weak self] coins in
                GlobalState.coins = coins
                self?._finishedLoading.onNext(())
            }, onError: { [weak self] error in
                self?._displayError.onNext(error)
            }).disposed(by: disposeBag)
    }
}
