import CoindarAPI

protocol LastEventsViewModelDelegate: AnyObject, Loadable {
    func update(_ items: [LastEventsViewModel.Item])
    func showDetails(for event: CoindarEvent)
}

class LastEventsViewModel {
    
    enum Item {
        case event(CoindarEvent)
        case header(Date)
        case loadMore(LoadMoreViewModel)
    }
    
    private var items: [Item] = [] {
        didSet {
            delegate?.update(items)
        }
    }
    
    private let loadMoreViewModel = LoadMoreViewModel()
    
    private let coindarService: CoindarService
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
        case .loadMore(let viewModel):
            if !viewModel.isLoading {
                fetchMoreEvents()
            }
            break
        }
    }
    
    var currentPage = 0
    func fetchMoreEvents() {
        if currentPage == 0 {
            self.delegate?.startLoading()
        } else {
            self.loadMoreViewModel.startLoading()
        }
        coindarService.fetchEventsToday(offset: currentPage) { [weak self] result in
            guard let `self` = self else { return }
            if self.currentPage == 0 {
                self.delegate?.stopLoading()
            } else {
                self.loadMoreViewModel.stopLoading()
            }
            switch result {
            case .error(let error):
                print("Error")
                print(error)
            case .success(let events):
                self.currentPage += 1
                var itemsToAppend: [Item] = [.header(events[0].startDate) ]
                itemsToAppend.append(contentsOf: events.map({ LastEventsViewModel.Item.event($0) }))
                itemsToAppend.append(.loadMore(self.loadMoreViewModel))
                DispatchQueue.main.async {
                    if self.items.count > 0 {
                        self.items.removeLast()
                    }
                    self.items.append(contentsOf: itemsToAppend)
                }
            }
        }
    }
    
}
