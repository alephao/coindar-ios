import CoindarAPI

class EventDetailsViewModel {
    
    private let event: CoindarEvent
    
    var eventCaption: String {
        return event.caption
    }

    var coinName: String {
        return "\(event.coinName) \(event.coinSymbol)"
    }
    
    var startOn: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Starts on \(CoindarEvent.Formatters.medium.string(from: event.publicDate))")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 9))
        return attributedString
    }
    
    var proofLink: URL? {
        return URL(string: event.proof)
    }
    
    init(event: CoindarEvent) {
        self.event = event
    }
    
}
