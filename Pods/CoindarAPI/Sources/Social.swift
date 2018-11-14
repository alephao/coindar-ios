//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

public struct Social {
    public let coinId: String
    public let website: URL?
    public let bitcointalk: URL?
    public let twitter: URL?
    public let reddit: URL?
    public let telegram: URL?
    public let facebook: URL?
    public let github: URL?
    public let explorer: URL?
    public let youtube: URL?
    public let twitterCount: String?
    public let redditCount: String?
    public let telegramCount: String?
    public let facebookCount: String?

    public init(coinId: String,
                website: URL?,
                bitcointalk: URL?,
                twitter: URL?,
                reddit: URL?,
                telegram: URL?,
                facebook: URL?,
                github: URL?,
                explorer: URL?,
                youtube: URL?,
                twitterCount: String?,
                redditCount: String?,
                telegramCount: String?,
                facebookCount: String?) {
        self.coinId = coinId
        self.website = website
        self.bitcointalk = bitcointalk
        self.twitter = twitter
        self.reddit = reddit
        self.telegram = telegram
        self.facebook = facebook
        self.github = github
        self.explorer = explorer
        self.youtube = youtube
        self.twitterCount = twitterCount
        self.redditCount = redditCount
        self.telegramCount = telegramCount
        self.facebookCount = facebookCount
    }
}

extension Social: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        coinId = try container.decode(String.self, forKey: .coinId)
        website = try? container.decode(URL.self, forKey: .website)
        bitcointalk = try? container.decode(URL.self, forKey: .bitcointalk)
        twitter = try? container.decode(URL.self, forKey: .twitter)
        reddit = try? container.decode(URL.self, forKey: .reddit)
        telegram = try? container.decode(URL.self, forKey: .telegram)
        facebook = try? container.decode(URL.self, forKey: .facebook)
        github = try? container.decode(URL.self, forKey: .github)
        explorer = try? container.decode(URL.self, forKey: .explorer)
        youtube = try? container.decode(URL.self, forKey: .youtube)
        twitterCount = try? container.decode(String.self, forKey: .twitterCount)
        redditCount = try? container.decode(String.self, forKey: .redditCount)
        telegramCount = try? container.decode(String.self, forKey: .telegramCount)
        facebookCount = try? container.decode(String.self, forKey: .facebookCount)
    }
}
