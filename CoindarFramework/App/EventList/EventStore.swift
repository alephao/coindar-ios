// Copyright © lalacode.io All rights reserved.

import Foundation
import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import CoindarAPI
import Combine

final class EventStore: BindableObject {
    let didChange = PassthroughSubject<EventStore, Never>()

    var events: [EventViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }

    private let disposeBag = DisposeBag()

    init(appState: AppState) {
        let params = EventsParams(page: 1, pageSize: 20, filterDateStart: nil, filterDateEnd: nil, filterCoins: nil, filterTags: nil, sortBy: .dateStart, orderBy: .ascending)
        let sink = Current.coindar.rx.getEventsSink(params: params)

        sink.success.map { events in
            events.zipWith(coins: appState.coins, tags: appState.tags).map(EventViewModel.init)
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] events in
                guard let self = self else { return }
                self.events = events
            })
            .disposed(by: disposeBag)
    }
}

extension Array where Element == CoindarAPI.Event {
    func zipWith(coins: [Coin], tags: [Tag]) -> [(CoindarAPI.Event, Coin, Tag)] {
        return compactMap { event in
            guard
                let coin = coins.first(where: property(\Coin.id, isEqual: event.coinId)),
                let tag = tags.first(where: property(\Tag.id, isEqual: event.tags)) else {
                    return nil
            }
            return (event, coin, tag)
        }
    }
}
