// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import Overture
import CoindarAPI

struct EventsViewModel {

    let events: Driver<[EventViewModel]>
    let isLoading: Driver<Bool>

    init(appState: AppState) {
        let params = EventsParams(page: 1, pageSize: 20, filterDateStart: nil, filterDateEnd: nil, filterCoins: nil, filterTags: nil, sortBy: .dateStart, orderBy: .ascending)
        let sink = Current.coindar.rx.getEventsSink(params: params)

        events = sink.success.map { events in
            events.compactMap(with: appState.coins).map(EventViewModel.init)
            }
            .asDriver(onErrorJustReturn: [])

        isLoading = sink.loading
    }
}

private extension Array where Element == CoindarAPI.Event {
    func compactMap(with coins: [Coin]) -> [(CoindarAPI.Event, Coin)] {
        return compactMap { event in
            let coin = coins.first(where: property(\Coin.id, isEqual: event.coinId))
            return zip(event, coin)
        }
    }
}
