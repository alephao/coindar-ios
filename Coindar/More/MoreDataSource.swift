import UIKit

class MoreDataSource: NSObject, UITableViewDataSource {
    
    typealias Item = MoreViewModel.Item
    
    private let items: [Item]
    
    init(items: [Item]) {
        self.items = items
        super.init()
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
        case .default(let title):
            let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIdentifier)
            cell.textLabel?.text = title
            return cell
        }
    }
    
}

