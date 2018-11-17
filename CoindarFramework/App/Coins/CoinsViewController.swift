// Copyright © lalacode.io All rights reserved.

import UIKit
import CoindarAPI
import RxSwift
import RxCocoa
import RxDataSources

public struct CoinListConfiguration: ListConfiguration {
    public typealias Cell = CoinCell
    public typealias Model = Coin

    public func setup(_ tableView: UITableView) {
        tableView.register(Cell.self)
        tableView.rowHeight = 60
    }

    public func load(into tableView: UITableView) -> Disposable {
        return Observable<[Model]>.from([GlobalState.coins])
            .bind(to: tableView.rx.items(cellIdentifier: Cell.reuseIdentifier, cellType: Cell.self)) {
                _, coin, cell in
                cell.setup(with: coin)
        }
    }
}

public let coinsViewController = ListViewController(configuration: CoinListConfiguration())
