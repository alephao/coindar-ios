import CoindarAPI

protocol LastEventsViewModelDelegate: AnyObject {
    func update(_ items: [LastEventsViewModel.Item])
    func showDetails(for event: CoindarEvent)
}

class LastEventsViewModel {
    
    enum Item {
        case event(CoindarEvent)
        case header(Date)
        case loadMore
    }
    
    private var items: [Item] = [] {
        didSet {
            delegate?.update(items)
        }
    }
    
    let coindarService: CoindarService
    weak var delegate: LastEventsViewModelDelegate?
    
    init(delegate: LastEventsViewModelDelegate, coindarService: CoindarService = ServiceProvider.shared.coindarService) {
        self.delegate = delegate
        self.coindarService = coindarService
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        switch selectedItem {
        case .event(let event):
            delegate?.showDetails(for: event)
            break
        case .header(_): break
        case .loadMore:
            fetchMoreEvents()
            break
        }
    }
    
    func fetchLastEvents() {
        
        coindarService.fetchLastEvents { [weak self] result in
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let events):
                var grouped = [String: [CoindarEvent]]()
                for event in events {
                    let key = CoindarEvent.Formatters.medium.string(from: event.startDate)
                    if let _ = grouped[key] {
                        grouped[key]!.append(event)
                    } else {
                        grouped[key] = [event]
                    }
                }
                
                var items = [Item]()
                for (_, value) in grouped {
                    items.append(.header(value[0].startDate))
                    items.append(contentsOf: value.map({ LastEventsViewModel.Item.event($0) }))
                }
                
                items.append(.loadMore)
                
                DispatchQueue.main.async {
                    self?.items = items
                }
            }
        }
    }
    
    func fetchEventsToday() {
        coindarService.fetchEventsToday(offset: 0) { [weak self] result in
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let events):
                var grouped = [String: [CoindarEvent]]()
                for event in events {
                    let key = CoindarEvent.Formatters.medium.string(from: event.startDate)
                    if let _ = grouped[key] {
                        grouped[key]!.append(event)
                    } else {
                        grouped[key] = [event]
                    }
                }
                
                var items = [Item]()
                for (_, value) in grouped {
                    items.append(.header(value[0].startDate))
                    items.append(contentsOf: value.map({ LastEventsViewModel.Item.event($0) }))
                }
                
                items.append(.loadMore)
                
                DispatchQueue.main.async {
                    self?.items = items
                }
            }
        }
    }
    
    var currentPage = 1
    func fetchMoreEvents() {
        coindarService.fetchEventsToday(offset: currentPage) { [weak self] result in
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let events):
                self?.currentPage += 1
                var itemsToAppend: [Item] = [.header(events[0].startDate) ]
                itemsToAppend.append(contentsOf: events.map({ LastEventsViewModel.Item.event($0) }))
                itemsToAppend.append(.loadMore)
                DispatchQueue.main.async {
                    self?.items.removeLast()
                    self?.items.append(contentsOf: itemsToAppend)
                }
            }
        }
    }
    
}
