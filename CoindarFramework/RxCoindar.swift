// Copyright © lalacode.io All rights reserved.

import RxSwift
import CoindarAPI
import Overture

enum Either<A, B> {
    enum Error: Swift.Error {
        case mapLeft
        case mapRight

        var localizedDescription: String {
            switch self {
            case .mapLeft: return "Expected left, but got right"
            case .mapRight:  return "Expected right, but got left"
            }
        }
    }

    case left(A)
    case right(B)

    static func filterLeft(_ instance: Either<A, B>) -> Bool {
        guard case .left = instance else { return false }
        return true
    }

    static func filterRight(_ instance: Either<A, B>) -> Bool {
        guard case .right = instance else { return false }
        return true
    }

    static func mapLeft(_ instance: Either<A, B>) throws -> A {
        guard case let .left(a) = instance else {
            throw Either.Error.mapLeft
        }
        return a
    }

    static func mapRight(_ instance: Either<A, B>) throws -> B {
        guard case let .right(b) = instance else {
            throw Either.Error.mapRight
        }
        return b
    }
}

fileprivate func closureToSingle<A, B>(_ a: A, _ f: @escaping (A, @escaping (B) -> Void, @escaping (Error) -> Void) -> Cancellable) -> Single<B> {
    return Single<B>.create(subscribe: { single in
        let fSuccess: (B) -> Void  = { b in
            single(.success(b))
        }

        let fError: (Error) -> Void = { err in
            single(.error(err))
        }

        _ = f(a, fSuccess, fError)

        return Disposables.create()
    })
}

fileprivate func closureToObservable<A, B>(_ f: @escaping (@escaping (A) -> Void, @escaping (B) -> Void, @escaping (Error) -> Void) -> Cancellable) -> Observable<Either<A, B>> {
    return Observable.create({ observer in

        let fA: (A) -> Void = { a in
            observer.onNext(.left(a))
        }

        let fB: (B) -> Void = { b in
            observer.onNext(.right(b))
            observer.onCompleted()
        }

        let fError: (Error) -> Void = { err in
            observer.onError(err)
        }

        _ = f(fA, fB, fError)

        return Disposables.create()
    })
}

extension Reactive where Base == Coindar {
    func getEvents(params: CoindarAPI.EventsParams) -> Single<[CoindarAPI.Event]> {
        return closureToSingle(params, base.getEvents(params:onSuccess:onError:))
    }

    func getSocial(coins: [CoindarAPI.Coin]) -> Single<[CoindarAPI.Social]> {
        return closureToSingle(coins, base.getSocial(coins:onSuccess:onError:))
    }

    func getTags() -> Observable<Either<Double, [CoindarAPI.Tag]>> {
        return closureToObservable(base.getTags(progress:onSuccess:onError:))
    }

    func getCoins() -> Observable<Either<Double, [CoindarAPI.Coin]>> {
        return closureToObservable(base.getCoins(progress:onSuccess:onError:))
    }
}

extension Coindar: ReactiveCompatible {}
