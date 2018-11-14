//  Copyright © 2018 Lalacode. All rights reserved.

import Moya
import Result

public typealias Cancellable = Moya.Cancellable

open class Coindar {
    
    private var provider: MoyaProvider<CoindarTarget>
    
    public init(token: String) {
        let authPlugin = AuthPlugin(token: token)
        provider = MoyaProvider<CoindarTarget>(plugins: [authPlugin])
    }
    
    open func getEvents(params: EventsParams,
                        onSuccess: @escaping ([Event]) -> Void,
                        onError: @escaping (Error) -> Void) -> Cancellable {
        return provider.request(.events(params)) { result in
            switch result {
            case .success(let response):
                do {
                    let events = try response.map([Event].self, atKeyPath: nil, using: JSONDecoder.events, failsOnEmptyData: true)
                    onSuccess(events)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    open func getCoins(progress: @escaping (Double) -> Void,
                       onSuccess: @escaping ([Coin]) -> Void,
                       onError: @escaping (Error) -> Void) -> Cancellable {
        return provider.request(.coins, progress: { progress($0.progress) }) { result in
            switch result {
            case .success(let response):
                do {
                    let events = try response.map([Coin].self, atKeyPath: nil, using: JSONDecoder.snake, failsOnEmptyData: true)
                    onSuccess(events)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    open func getTags(progress: @escaping (Double) -> Void,
                      onSuccess: @escaping ([Tag]) -> Void,
                      onError: @escaping (Error) -> Void) -> Cancellable {
        return provider.request(.tags, progress: { progress($0.progress) }) { result in
            switch result {
            case .success(let response):
                do {
                    let events = try response.map([Tag].self, atKeyPath: nil, using: JSONDecoder.snake, failsOnEmptyData: true)
                    onSuccess(events)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    open func getSocial(coins: [Coin],
                        onSuccess: @escaping ([Social]) -> Void,
                        onError: @escaping (Error) -> Void) -> Cancellable {
        let coinIds = coins.map({ $0.id })
        return provider.request(.social(coins: coinIds)) { result in
            switch result {
            case .success(let response):
                do {
                    let socialArray = try response.map([Social].self, atKeyPath: nil, using: JSONDecoder.snake, failsOnEmptyData: true)
                    onSuccess(socialArray)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
}
