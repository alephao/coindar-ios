import CoindarAPI

protocol LastEventsViewModelDelegate: AnyObject {
    func update(_ events: [CoindarEvent])
    func showDetails(for event: CoindarEvent)
}

class LastEventsViewModel {
    
    private var events: [CoindarEvent] = [] {
        didSet {
            delegate?.update(events)
        }
    }
    
    weak var delegate: LastEventsViewModelDelegate?
    
    init(delegate: LastEventsViewModelDelegate) {
        self.delegate = delegate    
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedEvent = events[indexPath.row]
        delegate?.showDetails(for: selectedEvent)
    }
    
    func fetchLastEvents() {
        let token = CoindarAPI.lastEvents(limit: nil)
        Networking().getData(token) { [weak self] result in
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let data):
                print("Success")
                let events = try! JSONDecoder().decode([CoindarEvent].self, from: data)
                DispatchQueue.main.async {
                    self?.events = events
                }
            }
        }
    }
    
}
