// Copyright © lalacode.io All rights reserved.

import CoindarAPI
import RxSwift
import Fakery

private let faker = Faker()

extension Tag {
    public static var mock: Tag {
        return Tag(
            id: faker.address.buildingNumber(),
            name: faker.lorem.word())
    }
}

extension Array where Element == Tag {
    public static func mock(_ amount: Int = 10) -> [Tag] {
        var tags: [Tag] = []
        for _ in 0...amount {
            tags.append(.mock)
        }
        return tags
    }
}

extension Observable where E == Array<Tag> {
    public static var mock: Observable<[Tag]> {
        return Observable.just(.mock())
    }
}
