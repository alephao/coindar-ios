import UIKit
import StoreKit

class MoreViewModel {
    
    struct Section {
        let title: String?
        let items: [Item]
    }
    
    enum Item {
        case `default`(String)
        case donationItem(String, String)
        case version(String, String)
        case appReview(String)
    }
    
    let donateSection: Section = {
        return Section(title: "Donate (tap to copy address)",
                       items: [
                        Item.donationItem("Bitcoin", "1KFe8vs2TiimD9M9pWjx3aQNNWUBd9nEh1"),
                        Item.donationItem("Ether and Ethereum Tokens", "0xCDA750ED5dfAadEd9910C729E9c5631756A30a85")
            ])
    }()
    
    let appReviewSection: Section = {
        return Section(title: nil, items: [Item.appReview("Leave a review")])
    }()
    
    let versionSection: Section = {
        var items = [Item]()
        if let infoDict = Bundle.main.infoDictionary,
            let version = infoDict["CFBundleShortVersionString"] as? String {
            items.append(Item.version("App Version", "v\(version)"))
        }
        return Section(title: nil,
                       items: items)
    }()
    
    let sections: [Section]
    
    weak var coordinator: MoreCoordinatorDelegate?
    let dataSource: MoreDataSource
    
    init(coordinator: MoreCoordinatorDelegate) {
        self.coordinator = coordinator
        var sections = [
            self.donateSection,
        ]
        
        if #available(iOS 10.3, *) {
            sections.append(self.appReviewSection)
        }
        
        sections.append(self.versionSection)
        
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
        case .appReview(_):
            showReviewAlert()
            break
        }
    }
    
    private func showReviewAlert() {
        if #available(iOS 10.3, *) {
            let alert = UIAlertController(title: "Review", message: "Are you enjoying the app?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes!", style: .default, handler: { _ in
                SKStoreReviewController.requestReview()
            })
            let no = UIAlertAction(title: "No", style: .destructive, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            DispatchQueue.main.async {
                AppDelegate.shared.window!.rootViewController!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
