//  Copyright © 2018 Aleph Retamal. All rights reserved.

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, utc: Bool = true) {
        self.init()
        self.dateFormat = dateFormat
        if utc {
            timeZone = TimeZone(secondsFromGMT: 0)
        }
    }
}
