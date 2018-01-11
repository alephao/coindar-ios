import UIKit
import CoindarAPI

class LastEventsDataSource: NSObject, UITableViewDataSource {
    
    private var events: [CoindarEvent] = []
    
    init(events: [CoindarEvent]) {
        self.events = events
    }
    
    func setEvents(_ events: [CoindarEvent]) {
        self.events = events
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventCell = tableView.dequeueReusableCell()
        let event = events[indexPath.row]
        cell.setup(event)
        return cell
    }
    
}
