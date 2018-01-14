import CoindarAPI

class EventDetailsViewModel {
    
    var eventCaption: String {
        return event.caption
    }

    var coinName: String {
        return "\(event.coinName) \(event.coinSymbol)"
    }
    
    var startOn: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Starts on \(CoindarEvent.Formatters.medium.string(from: event.startDate))")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 9))
        return attributedString
    }
    
    var proofLink: URL? {
        return URL(string: event.proof)
    }
    
    private let event: CoindarEvent
    private weak var coordinator: EventDetailsCoordinatorDelegate?
    
    init(event: CoindarEvent, coordinator: EventDetailsCoordinatorDelegate) {
        self.event = event
        self.coordinator = coordinator
    }
    
    func openProofLink() {
        guard let url = proofLink else { return }
        coordinator?.showSafariView(url: url)
    }
}
