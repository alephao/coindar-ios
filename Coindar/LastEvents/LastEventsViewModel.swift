import CoindarAPI

protocol LastEventsViewModelDelegate: AnyObject {
    func update(_ sections: [LastEventsViewModel.Section])
    func showDetails(for event: CoindarEvent)
}

class LastEventsViewModel {
    
    struct Section {
        let title: String
        var items: [CoindarEvent]
    }
    
    private var sections: [Section] = [] {
        didSet {
            delegate?.update(sections)
        }
    }
    
    let coindarService: CoindarService
    weak var delegate: LastEventsViewModelDelegate?
    
    init(delegate: LastEventsViewModelDelegate, coindarService: CoindarService = ServiceProvider.shared.coindarService) {
        self.delegate = delegate
        self.coindarService = coindarService
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedEvent = sections[indexPath.section].items[indexPath.row]
        delegate?.showDetails(for: selectedEvent)
    }
    
    func fetchLastEvents() {

        coindarService.fetchLastEvents { [weak self] result in
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let events):
                let sections = events.reduce([Section]()) { secs, event in
                    let title = CoindarEvent.Formatters.medium.string(from: event.startDate)
                    
                    var secs = secs
                    
                    if let i = secs.index(where: { sec in sec.title == title }) {
                        secs[i].items.append(event)
                        return secs
                    } else {
                        secs.append(Section(title: title, items: [event]))
                        return secs
                    }
                }
                
                DispatchQueue.main.async {
                    self?.sections = sections
                }
            }
        }
    }
    
}
