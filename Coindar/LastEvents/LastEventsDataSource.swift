import UIKit
import CoindarAPI

class LastEventsDataSource: NSObject, UITableViewDataSource {
    
    private var items: [LastEventsViewModel.Item] = []
    
    init(items: [LastEventsViewModel.Item]) {
        self.items = items
    }
    
    func setItems(_ items: [LastEventsViewModel.Item]) {
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        switch item {
        case .event(let event):
            let cell: EventCell = tableView.dequeueReusableCell()
            cell.setup(event)
            return cell
        case .header(let title):
            let cell: HeaderCell = tableView.dequeueReusableCell()
            cell.setup(title: title)
            return cell
            break
        case .loadMore:
            let cell: LoadMoreCell = tableView.dequeueReusableCell()
            return cell
        }
    }
    
}
