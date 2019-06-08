// Copyright © lalacode.io All rights reserved.

import CoindarKit

enum TagStyle: Int {
    case unknown = -1
    case general = 1
    case ama = 2
    case announcement
    case airdrop
    case brand
    case burn
    case conference
    case contest
    case exchange
    case hardFork
    case ico
    case law
    case meetup
    case partnership
    case release
    case softFork
    case swap
    case test
    case update
    case report

    var color: CKColor {
        switch self {
        case .general: return .tagGeneral
        case .ama: return .tagAma
        case .announcement: return .tagAnnouncement
        case .airdrop: return .tagAirdrop
        case .brand: return .tagBrand
        case .burn: return .tagBurn
        case .conference: return .tagConference
        case .contest: return .tagContest
        case .exchange: return .tagExchange
        case .hardFork: return .tagHardFork
        case .ico: return .tagIco
        case .law: return .tagLaw
        case .meetup: return .tagMeetup
        case .partnership: return .tagPartnership
        case .release: return .tagRelease
        case .softFork: return .tagSoftFork
        case .swap: return .tagSwap
        case .test: return .tagTest
        case .update: return .tagUpdate
        case .report: return .tagReport
        case .unknown: return .gray
        }
    }
}
