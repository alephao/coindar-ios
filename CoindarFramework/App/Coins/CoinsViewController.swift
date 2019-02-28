// Copyright © lalacode.io All rights reserved.

import UIKit
import CoindarAPI
import RxSwift
import RxDataSources
import Overture
import Nuke
import SnapKit

public final class CoinsViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let viewModel: CoinsViewModel

    public init(appState: AppState) {
        viewModel = CoinsViewModel(appState: appState)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let e = UITableView.standard
        e.register(CoinCell.self)
        e.rowHeight = 60
        return e
    }()

    override public func loadView() {
        super.loadView()
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel.coins
            .drive(tableView.rx.items(cellIdentifier: CoinCell.reuseIdentifier, cellType: CoinCell.self)) {
                _, coin, cell in
                cell.setup(with: coin)
            }.disposed(by: disposeBag)
    }

}
