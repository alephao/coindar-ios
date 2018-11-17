// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa

public protocol ListConfiguration {
    associatedtype Cell: UITableViewCell
    associatedtype Model

    var rowHeight: CGFloat { get }

    func load(into tableView: UITableView) -> Disposable
}

extension ListConfiguration {
    func setup(_ tableView: UITableView) {
        tableView.register(Cell.self)
        tableView.rowHeight = rowHeight
    }
}

public final class ListViewController<Configuration: ListConfiguration>: UIViewController {
    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let e = UITableView.standard
        configuration.setup(e)
        return e
    }()

    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        super.loadView()
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configuration.load(into: tableView)
            .disposed(by: disposeBag)
    }
}
