import UIKit

class MoreViewController: ViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.registerCell(UITableViewCell.self)
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 80
        tv.tableFooterView = UIView()
//        tv.separatorInset = .zero
        tv.separatorColor = UIColor.hex(0xa0a0a0)
        return tv
    }()
    
    fileprivate let viewModel: MoreViewModel
    
    init(viewModel: MoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "More"
        
        tableView.delegate = self
        tableView.dataSource = viewModel.dataSource
        
        tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "ic_more_horiz"), tag: 1)
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
    }
}

extension MoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

