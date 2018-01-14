import CoindarAPI

protocol LastEventsViewModelDelegate: AnyObject, Loadable {
    func update(_ items: [LastEventsViewModel.Item])
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
    weak var coordinator: LastEventsCoordinatorDelegate?
    
    init(coindarService: CoindarService,
         coordinator: LastEventsCoordinatorDelegate) {
        self.coindarService = coindarService
        self.coordinator = coordinator
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        switch selectedItem {
        case .event(let event):
            coordinator?.showEventDetails(for: event)
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
                let eventsToAdd = events.sorted(by: { a, b in
                    a.publicDate.compare(b.publicDate) == .orderedDescending
                })
                .map({ LastEventsViewModel.Item.event($0) })
                itemsToAppend.append(contentsOf: eventsToAdd)
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
