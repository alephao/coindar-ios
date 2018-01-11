import UIKit
import CoindarAPI

class LastEventsDataSource: NSObject, UITableViewDataSource {
    
    private var sections: [LastEventsViewModel.Section] = []
    
    init(sections: [LastEventsViewModel.Section]) {
        self.sections = sections
    }
    
    func setSections(_ sections: [LastEventsViewModel.Section]) {
        self.sections = sections
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventCell = tableView.dequeueReusableCell()
        let event = sections[indexPath.section].items[indexPath.row]
        cell.setup(event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}
