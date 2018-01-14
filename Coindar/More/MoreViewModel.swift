import UIKit

class MoreViewModel {
    
    struct Section {
        let title: String?
        let items: [Item]
    }
    
    enum Item {
        case `default`(String)
        case donationItem(String, String)
        case version(String, String)
    }
    
    let donateSection: Section = {
        return Section(title: "Donate (tap to copy address)",
                       items: [
                        Item.donationItem("Bitcoin", "1KFe8vs2TiimD9M9pWjx3aQNNWUBd9nEh1"),
                        Item.donationItem("Ether and Ethereum Tokens", "0xCDA750ED5dfAadEd9910C729E9c5631756A30a85")
            ])
    }()
    
    let versionSection: Section? = {
        if let infoDict = Bundle.main.infoDictionary,
            let version = infoDict["CFBundleShortVersionString"] as? String {
            return Section(title: nil,
                           items: [Item.version("App Version", "v\(version)")])
        }
        return nil
    }()
    
    let sections: [Section]
    
    weak var coordinator: MoreCoordinatorDelegate?
    let dataSource: MoreDataSource
    
    init(coordinator: MoreCoordinatorDelegate) {
        self.coordinator = coordinator
        var sections = [
            self.donateSection,
        ]
        
        if let versionSection = versionSection {
            sections.append(versionSection)
        }
        
        self.sections = sections
        
        dataSource = MoreDataSource(sections: sections)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedItem = sections[indexPath.section].items[indexPath.row]
        
        switch selectedItem {
        case .default(_): break
        case .donationItem(_, let address):
            UIPasteboard.general.string = address
            AppDelegate.shared.showCopiedFeedback()
            break
        case .version(_, _): break
        }
    }
    
}
