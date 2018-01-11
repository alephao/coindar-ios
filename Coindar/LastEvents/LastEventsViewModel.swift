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
        let json = """
        [
        {
            "caption": "BLUE Wallet Chrome Extension Update",
            "proof": "https://coindar.org/en/event/blue-blue-blue-wallet-chrome-extension-update-1753",
            "caption_ru": "Обновление расширения для Chrome",
            "proof_ru": "https://coindar.org/ru/event/blue-blue-obnovlenie-rasshireniya-dlya-chrome-1753",
            "public_date": "2018-1-10 19:16",
            "start_date": "2018-2",
            "end_date": "",
            "coin_name": "BLUE",
            "coin_symbol": "BLUE"
        },
        {
            "caption": "Cash Poker Pro Poker Room Launch",
            "proof": "https://coindar.org/en/event/cash-poker-pro-cash-cash-poker-pro-poker-room-launch-1752",
            "caption_ru": "Запуск покер-рума Cash Poker Pro",
            "proof_ru": "https://coindar.org/ru/event/cash-poker-pro-cash-zapusk-pokerruma-cash-poker-pro-1752",
            "public_date": "2018-1-10 19:13",
            "start_date": "2018-2",
            "end_date": "",
            "coin_name": "Cash Poker Pro",
            "coin_symbol": "CASH"
        },
        {
            "caption": "10 DBC for the Registration on Huobi Pro",
            "proof": "https://coindar.org/en/event/deepbrain-chain-dbc-10-dbc-for-the-registration-on-huobi-pro-1751",
            "caption_ru": "10 DBC за регистрацию на Huobi Pro",
            "proof_ru": "https://coindar.org/ru/event/deepbrain-chain-dbc-10-dbc-za-registraciyu-na-huobi-pro-1751",
            "public_date": "2018-1-10 19:08",
            "start_date": "2018-1-10",
            "end_date": "",
            "coin_name": "DeepBrain Chain",
            "coin_symbol": "DBC"
        }]
        """

        let data = json.data(using: .utf8)!
        let events = try! JSONDecoder().decode([CoindarEvent].self, from: data)
        self.events = events
        
//        let token = CoindarAPI.lastEvents(limit: nil)
//        Networking().getData(token) { [weak self] result in
//            switch result {
//            case .error(let error):
//                print("Error")
//                print(error)
//            case .success(let data):
//                print("Success")
//                let events = try! JSONDecoder().decode([CoindarEvent].self, from: data)
//                DispatchQueue.main.async {
//                    self?.events = events
//                }
//            }
//        }
    }
    
}
