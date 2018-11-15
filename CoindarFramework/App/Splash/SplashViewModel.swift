// Copyright © lalacode.io All rights reserved.

import Foundation
import RxSwift
import RxCocoa
import Overture
import CoindarAPI

internal class SplashViewModel {

    private let disposeBag = DisposeBag()

    let progress: Driver<Float>

    private let _displayError: PublishSubject<Error> = .init()
    lazy var displayError: Observable<Error> = _displayError

    private let _finishedLoading: PublishSubject<Void> = .init()
    lazy var finishedLoading: Observable<Void> = _finishedLoading

    init(coordinator: AppCoordinator) {
        let coinsRequest = Current.coindar.rx.getCoins().share()
        let tagsRequest = Current.coindar.rx.getTags().share()

        progress = totalProgressFromRequests(getProgressFromRequest(coinsRequest),
                                             getProgressFromRequest(tagsRequest))
            .asDriver(onErrorJustReturn: 0)

        Observable
            .zip(getRight(coinsRequest), getRight(tagsRequest))
            .subscribe(
                onNext: { [weak self] (coins, tags) in
                    GlobalState.coins = coins
                    GlobalState.tags = tags
                    self?._finishedLoading.onNext(())
                },
                onError: { [weak self] error in
                    self?._displayError.onNext(error)
            }).disposed(by: disposeBag)

        coordinator.bind(gotoCoinsObservable: finishedLoading)
    }
}

private func getProgressFromRequest<T>(_ observable: Observable<Either<Double, T>>) -> Observable<Float> {
    return observable
        .filter(Either.filterLeft)
        .map(pipe(Either.mapLeft, Float.init))
        .catchErrorJustReturn(0)
}

private func totalProgressFromRequests(_ observables: Observable<Float>...) -> Observable<Float> {
    return Observable.combineLatest(observables) { obs in
        return obs.reduce(0, +) / Float(obs.count)
    }
}

private func getRight<A, B>(_ observable: Observable<Either<A, B>>) -> Observable<B> {
    return observable
        .filter(Either.filterRight)
        .map(Either.mapRight)
}
