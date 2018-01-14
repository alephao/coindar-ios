import Foundation

class MoreViewModel {
    
    enum Item {
        case `default`(String)
    }
    
    var items: [Item] = {
        var items = [
            Item.default("Donate Bitcoin"),
            Item.default("Donate Ether"),
        ]
        if let infoDict = Bundle.main.infoDictionary,
            let version = infoDict["CFBundleShortVersionString"] as? String {
            items.append(Item.default("v\(version)"))
        }
        return items
    }()
    
    weak var coordinator: MoreCoordinatorDelegate?
    let dataSource: MoreDataSource
    
    init(coordinator: MoreCoordinatorDelegate) {
        self.coordinator = coordinator
        dataSource = MoreDataSource(items: self.items)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        switch selectedItem {
        case .default(_): break
        }
    }
    
}
