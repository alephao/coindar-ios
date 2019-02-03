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

    private let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let edge = (UIScreen.main.bounds.width / 2) - 8
        flow.estimatedItemSize = CGSize(edge: edge)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let e = UICollectionView(frame: .zero, collectionViewLayout: flow)
        e.register(EventCell.self)
        return e
    }()

    override public func loadView() {
        super.loadView()
        view = collectionView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel
            .events
            .debug()
            .drive(collectionView.rx.items(cellIdentifier: EventCell.reuseIdentifier, cellType: EventCell.self)) { _, eventViewModel, cell in
                cell.setup(with: eventViewModel)
        }.disposed(by: disposeBag)
    }

}
