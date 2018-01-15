import UIKit
import CoindarFoundation
import CoindarAPI

class LastEventsViewController: ViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.registerCell(EventCell.self)
        tv.registerCell(LoadMoreCell.self)
        tv.registerCell(HeaderCell.self)
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 80
        tv.tableFooterView = UIView()
        tv.separatorInset = .zero
        tv.separatorColor = UIColor.hex(0xa0a0a0)
        return tv
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let eventsDataSource = LastEventsDataSource(items: [])
    fileprivate let viewModel: LastEventsViewModel
    
    init(viewModel: LastEventsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Last Events"
        tableView.delegate = self
        tableView.dataSource = eventsDataSource
        
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .primaryActionTriggered)
        
        tabBarItem = UITabBarItem(title: "Last Events", image: #imageLiteral(resourceName: "ic_view_list"), tag: 0)
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
        
        viewModel.fetchMoreEvents()
    }
    
    @objc
    private func refresh() {
        viewModel.refresh()
    }
    
    override func startLoading() {
        DispatchQueue.main.async {
            self.refreshControl.beginRefreshing()
        }
    }
    
    override func stopLoading() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

extension LastEventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension LastEventsViewController: LastEventsViewModelDelegate {
    func update(_ items: [LastEventsViewModel.Item]) {
        eventsDataSource.setItems(items)
        tableView.reloadData()
    }
}
