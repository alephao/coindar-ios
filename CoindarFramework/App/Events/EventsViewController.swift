// Copyright © lalacode.io All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import CoindarAPI

public final class EventsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel: EventsViewModel

    public init(appState: AppState) {
        viewModel = EventsViewModel(appState: appState)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let e = UITableView.standard
        e.rowHeight = UITableView.automaticDimension
        e.register(EventCell.self)
        return e
    }()

    override public func loadView() {
        super.loadView()
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        view.backgroundColor = .white

        viewModel
            .events
            .drive(tableView.rx.items(cellIdentifier: EventCell.reuseIdentifier, cellType: EventCell.self)) { _, eventViewModel, cell in
                cell.setup(with: eventViewModel)
        }
            .disposed(by: disposeBag)
    }

}
