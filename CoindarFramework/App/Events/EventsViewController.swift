// Copyright © lalacode.io All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import CoindarAPI
import SafariServices

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

        viewModel.events
            .drive(tableView.rx.items(cellIdentifier: EventCell.reuseIdentifier, cellType: EventCell.self)) { _, eventViewModel, cell in
                cell.setup(with: eventViewModel)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(EventViewModel.self)
            .subscribe(onNext: { [weak self] eventViewModel in
                if let proofUrl = eventViewModel.proofUrl {
                    self?.openSafari(with: proofUrl)
                } else {
                    self?.showNoProofSourceAlert()
                }
            })
            .disposed(by: disposeBag)
    }

    public func openSafari(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }

    public func showNoProofSourceAlert() {
        let alertController = UIAlertController(title: nil, message: "No source of proof available", preferredStyle: .alert)
        alertController.addAction(.ok)
        present(alertController, animated: true, completion: nil)
    }
}

extension EventsViewController: SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
