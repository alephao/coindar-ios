import UIKit

class MoreDataSource: NSObject, UITableViewDataSource {
    
    typealias Item = MoreViewModel.Item
    typealias Section = MoreViewModel.Section
    
    private let sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .default(let title):
            let cell = UITableViewCell(style: .default,
                                       reuseIdentifier: UITableViewCell.reuseIdentifier)
            cell.textLabel?.text = title
            return cell
        case .donationItem(let coin, let address):
            let cell: SubtitleCell = tableView.dequeueReusableCell()
            cell.setup(title: coin, subtitle: address)
            return cell
        case .version(let title, let detail):
            let cell: DetailCell = tableView.dequeueReusableCell()
            cell.setup(title: title, detail: detail)
            return cell
        case .appReview(let title):
            let cell: DetailCell = tableView.dequeueReusableCell()
            cell.setup(title: title, detail: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}

