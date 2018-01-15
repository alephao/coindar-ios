import CoindarFoundation
import CoindarAPI

class CoindarService: Service {
    
    typealias CoindarCallback = (Result<[CoindarEvent]>) -> Void
    
    static let calendar = Calendar(identifier: .gregorian)
    
    func fetchLastEvents(callback: @escaping CoindarCallback) {
        
        let token = CoindarAPI.lastEvents(limit: nil)
        provider.networking.getData(token) { result in
            switch result {
            case .error(let error):
                callback(.error(error))
                break
            case .success(let data):
                do {
                    let events = try JSONDecoder().decode([CoindarEvent].self, from: data)
                    callback(.success(events))
                } catch {
                    callback(.error(error))
                }
            }
        }
    }
    
    /// Fetch events this month + offset
    func fetchEventsThisMonth(offset: Int = 0, callback: @escaping CoindarCallback) {
        let today = Date().addingTimeInterval(Double(86400 * offset))
        let month = CoindarService.calendar.component(.month, from: today)
        let year = CoindarService.calendar.component(.year, from: today)
        
        let token = CoindarAPI.events(year: year,
                                      month: month,
                                      day: nil)
        
        provider.networking.getData(token) { result in
            switch result {
            case .error(let error):
                callback(.error(error))
                break
            case .success(let data):
                do {
                    let events = try JSONDecoder().decode([CoindarEvent].self, from: data)
                    callback(.success(events))
                } catch {
                    callback(.error(error))
                }
            }
        }
    }
    
    func fetchEventsToday(offset: Int = 0, callback: @escaping CoindarCallback) {
        let today = Date().addingTimeInterval(Double(86400 * offset))
        let day = CoindarService.calendar.component(.day, from: today)
        let month = CoindarService.calendar.component(.month, from: today)
        let year = CoindarService.calendar.component(.year, from: today)
        
        let token = CoindarAPI.events(year: year,
                                      month: month,
                                      day: day)
        
        provider.networking.getData(token) { result in
            switch result {
            case .error(let error):
                callback(.error(error))
                break
            case .success(let data):
                do {
                    let events = try JSONDecoder().decode([CoindarEvent?].self, from: data)
                    let nonNilEvents = events
                        .filter { $0 != nil }
                        .map { $0! }
                    callback(.success(nonNilEvents))
                } catch {
                    callback(.error(error))
                }
            }
        }
    }
    
}

class CoindarServiceMock: CoindarService {
    override func fetchLastEvents(callback: @escaping (Result<[CoindarEvent]>) -> Void) {
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
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            callback(.success(events))
        }
    }
    
    override func fetchEventsToday(offset: Int, callback: @escaping CoindarService.CoindarCallback) {
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
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            callback(.success(events))
        }
    }
}
