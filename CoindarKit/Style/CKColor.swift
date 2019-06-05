// Copyright © lalacode.io All rights reserved.

import SwiftUI

public enum CKColor: Int {
    case link = 0x3e5ca7
    case gray = 0xfefefe

    // Tags Colors
    case tagGeneral = 0x7d93cf
    case tagAma = 0x99b150
    case tagAnnouncement = 0x9a95c5
    case tagAirdrop = 0x57c398
    case tagBrand = 0x7da2c7
    case tagBurn = 0xdc7692
    case tagConference = 0xa88cbd
    case tagContest = 0xd87ca6
    case tagExchange = 0xc39576
    case tagHardFork = 0xe07272
    case tagIco = 0x69b2a0
    case tagLaw = 0x67b2cb
    case tagMeetup = 0x78b7d6
    case tagPartnership = 0xc585b7
    case tagRelease = 0x8cbf80
    case tagSoftFork = 0xeaaa6d
    case tagSwap = 0x7eb7bd
    case tagTest = 0xd4b763
    case tagUpdate = 0xc3c27c
    case tagReport = 0xbab57e
}

extension CKColor {
    public var swiftUi: Color {
        return Color(hex: rawValue)
    }

    public var uiKit: UIColor {
        return UIColor(hex: rawValue)
    }
}
