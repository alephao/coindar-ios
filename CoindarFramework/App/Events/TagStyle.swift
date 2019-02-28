// Copyright © lalacode.io All rights reserved.

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

    var color: UIColor {
        switch self {
        case .general: return UIColor(rgb: 0x7d93cf)
        case .ama: return UIColor(rgb: 0x99b150)
        case .announcement: return UIColor(rgb: 0x9a95c5)
        case .airdrop: return UIColor(rgb: 0x57c398)
        case .brand: return UIColor(rgb: 0x7da2c7)
        case .burn: return UIColor(rgb: 0xdc7692)
        case .conference: return UIColor(rgb: 0xa88cbd)
        case .contest: return UIColor(rgb: 0xd87ca6)
        case .exchange: return UIColor(rgb: 0xc39576)
        case .hardFork: return UIColor(rgb: 0xe07272)
        case .ico: return UIColor(rgb: 0x69b2a0)
        case .law: return UIColor(rgb: 0x67b2cb)
        case .meetup: return UIColor(rgb: 0x78b7d6)
        case .partnership: return UIColor(rgb: 0xc585b7)
        case .release: return UIColor(rgb: 0x8cbf80)
        case .softFork: return UIColor(rgb: 0xeaaa6d)
        case .swap: return UIColor(rgb: 0x7eb7bd)
        case .test: return UIColor(rgb: 0xd4b763)
        case .update: return UIColor(rgb: 0xc3c27c)
        case .report: return UIColor(rgb: 0xbab57e)
        case .unknown: return .gray
        }
    }
}
