// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import Overture
import CoindarAPI

//struct EventsViewModel {
//
//    let events: Driver<[EventViewModel]>
//    let isLoading: Driver<Bool>
//
//    init(appState: AppState) {
//        let params = EventsParams(page: 1, pageSize: 20, filterDateStart: nil, filterDateEnd: nil, filterCoins: nil, filterTags: nil, sortBy: .dateStart, orderBy: .ascending)
//        let sink = Current.coindar.rx.getEventsSink(params: params)
//
//        events = sink.success.map { events in
//            events.zipWith(coins: appState.coins, tags: appState.tags).map(EventViewModel.init)
//            }
//            .asDriver(onErrorJustReturn: [])
//
//        isLoading = sink.loading
//    }
//}
//
extension Array where Element == CoindarAPI.Event {
    func zipWith(coins: [Coin], tags: [Tag]) -> [(CoindarAPI.Event, Coin, Tag)] {
        return compactMap { event in
            let coin = coins.first(where: property(\Coin.id, isEqual: event.coinId))
            let tag = tags.first(where: property(\Tag.id, isEqual: event.tags))
            return zip(event, coin, tag)
        }
    }
}
