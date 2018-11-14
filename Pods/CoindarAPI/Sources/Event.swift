//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct Event {
    public let caption: String
    public let source: URL
    public let proof: URL?
    public let datePublic: Date
    public let dateStart: Date
    public let dateEnd: Date?
    public let coinId: String
    public let coinPriceChanges: String
    public let tags: String

    public init(caption: String,
                source: URL,
                proof: URL?,
                datePublic: Date,
                dateStart: Date,
                dateEnd: Date?,
                coinId: String,
                coinPriceChanges: String,
                tags: String) {
        self.caption = caption
        self.source = source
        self.proof = proof
        self.datePublic = datePublic
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.coinId = coinId
        self.coinPriceChanges = coinPriceChanges
        self.tags = tags
    }
}

extension Event {
    enum EventDateFormatter {
        static let utc = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm")
        static let noTime = DateFormatter(dateFormat: "yyyy-MM-dd")
        static let month = DateFormatter(dateFormat: "yyyy-MM")
        static let quarter = DateFormatter(dateFormat: "yyyy-QQQ")
        static func dateStart(from string: String) -> Date? {
            return utc.date(from: string)
                ?? noTime.date(from: string)
                ?? month.date(from: string)
                ?? quarter.date(from: string)
        }
    }
}

extension Event: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        caption = try container.decode(String.self, forKey: .caption)
        source = try container.decode(URL.self, forKey: .source)
        proof = try? container.decode(URL.self, forKey: .proof)
        datePublic = try container.decode(Date.self, forKey: .datePublic)
        guard let dateStart = EventDateFormatter.dateStart(from: try container.decode(String.self, forKey: .dateStart)) else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.dateStart, in: container, debugDescription: "Failed to create date from string:")
        }
        self.dateStart = dateStart
        dateEnd = try? container.decode(Date.self, forKey: .dateEnd)
        coinId = try container.decode(String.self, forKey: .coinId)
        coinPriceChanges = try container.decode(String.self, forKey: .coinPriceChanges)
        tags = try container.decode(String.self, forKey: .tags)
    }
}
