import UIKit
import CoindarFoundation
import CoindarAPI

class LastEventsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.registerCell(EventCell.self)
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 80
        tv.tableFooterView = UIView()
        tv.separatorInset = .zero
        tv.separatorColor = UIColor.hex(0xa0a0a0)
        return tv
    }()
    
    private let eventsDataSource = LastEventsDataSource(sections: [])
    fileprivate lazy var viewModel: LastEventsViewModel = LastEventsViewModel(delegate: self)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Last Events"
        tableView.delegate = self
        tableView.dataSource = eventsDataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        viewModel.fetchLastEvents()
    }
}

extension LastEventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension LastEventsViewController: LastEventsViewModelDelegate {
    func showDetails(for event: CoindarEvent) {
        let eventDetailsViewModel = EventDetailsViewModel(event: event)
        let eventDetailsViewController = EventDetailsViewController(viewModel: eventDetailsViewModel)
        navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
    func update(_ sections: [LastEventsViewModel.Section]) {
        eventsDataSource.setSections(sections)
        tableView.reloadData()
    }
}
