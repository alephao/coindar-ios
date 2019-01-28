//  Copyright © 2018 Lalacode. All rights reserved.

import Moya
import Result

public typealias Cancellable = Moya.Cancellable

open class Coindar {
    
    private var provider: MoyaProvider<CoindarTarget>

    private lazy var requestWithProgress = { [provider] (f: @escaping (Double) -> Void) in
        return curryRequest(provider.request)(.none)({ f($0.progress) })
    }
    private lazy var request = curryRequest(provider.request)(.none)(.none)
    
    public init(token: String) {
        let authPlugin = AuthPlugin(token: token)
        provider = MoyaProvider<CoindarTarget>(plugins: [authPlugin])
    }
    
    open func getEvents(params: EventsParams,
                        onSuccess: @escaping ([Event]) -> Void,
                        onError: @escaping (Error) -> Void) -> Cancellable {
        return executeRequest(
            request(
                .events(params)
            ),
            decoder: .events,
            onSuccess: onSuccess,
            onError: onError
        )
    }
    
    open func getCoins(progress: @escaping (Double) -> Void,
                       onSuccess: @escaping ([Coin]) -> Void,
                       onError: @escaping (Error) -> Void) -> Cancellable {
        return executeRequest(
            requestWithProgress(progress)(
                .coins
            ),
            onSuccess: onSuccess,
            onError: onError
        )
    }
    
    open func getTags(progress: @escaping (Double) -> Void,
                      onSuccess: @escaping ([Tag]) -> Void,
                      onError: @escaping (Error) -> Void) -> Cancellable {
        return executeRequest(
            requestWithProgress(progress)(
                .tags
            ),
            onSuccess: onSuccess,
            onError: onError
        )
    }
    
    open func getSocial(coins: [Coin],
                        onSuccess: @escaping ([Social]) -> Void,
                        onError: @escaping (Error) -> Void) -> Cancellable {
        let coinIds = coins.map({ $0.id })
        return executeRequest(
            request(
                .social(coins: coinIds)
            ),
            onSuccess: onSuccess,
            onError: onError
        )
    }
}

private func curryRequest<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> (B) -> (C) -> (A) -> (D) -> E {
    return { b in return { c in return { a in return { d in return f(a, b, c, d) } } } }
}

private func executeRequest<T: Decodable>(
    _ f: @escaping (@escaping Completion) -> Cancellable,
    decoder: JSONDecoder = .snake,
    onSuccess: @escaping (T) -> Void,
    onError: @escaping (Error) -> Void)
    -> Cancellable {
        return f({ result in
            switch result {
            case .success(let response):
                do {
                    let events = try response.map(T.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)
                    onSuccess(events)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        })
}
