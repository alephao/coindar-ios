// Copyright © lalacode.io All rights reserved.

import CoindarAPI
import RxSwift
import Fakery

private let faker = Faker()

extension Coin {
    public static var mock: Coin {
        return Coin(
            id: faker.company.suffix(),
            name: faker.company.name(),
            symbol: faker.company.suffix(),
            image32: URL(string: faker.internet.image(width: 32, height: 32))!,
            image64: URL(string: faker.internet.image(width: 64, height: 64))!)
    }
}

extension Array where Element == Coin {
    static func mock(_ amount: Int = 10) -> [Coin] {
        var coins: [Coin] = []
        for _ in 0...amount {
            coins.append(.mock)
        }
        return coins
    }
}

extension Observable where E == Array<Coin> {
    public static var mock: Observable<[Coin]> {
        return Observable.just(.mock())
    }
}
