// Copyright © lalacode.io All rights reserved.

import RxSwift
import CoindarAPI
import Overture

extension Reactive where Base == Coindar {
    func getEventsSink(params: CoindarAPI.EventsParams) -> RequestSink<[CoindarAPI.Event]> {
        return params
            |> curry(base.getEvents)
            >>> uncurry
            >>> RequestSink.init
    }

    func getSocialSink(coins: [CoindarAPI.Coin]) -> RequestSink<[CoindarAPI.Social]> {
        return coins
            |> curry(base.getSocial)
            >>> uncurry
            >>> RequestSink.init
    }

    func getTagsSink() -> RequestProgressSink<[CoindarAPI.Tag]> {
        return RequestProgressSink(base.getTags)
    }

    func getCoinsSink() -> RequestProgressSink<[CoindarAPI.Coin]> {
        return RequestProgressSink(base.getCoins)
    }
}

extension Coindar: ReactiveCompatible {}
