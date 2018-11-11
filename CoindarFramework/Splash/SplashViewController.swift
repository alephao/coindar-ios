//  Copyright © lalacode.io All rights reserved.

import UIKit
import Overture
import SnapKit
import CoindarAPI
import RxSwift
import RxCocoa

public class SplashViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let viewModel = SplashViewModel()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let progressView = UIProgressView(progressViewStyle: .default)

        let loadingLabel = UILabel()
        loadingLabel.text = "Loading Coins..."

        let stack = UIStackView(arrangedSubviews: [loadingLabel, progressView])
        stack.axis = .vertical
        stack.distribution = .fill

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        viewModel.progress
            .drive(progressView.rx.progress)
            .disposed(by: disposeBag)

        viewModel.displayError
            .subscribe(onNext: displayErrorAlert(presentedBy: self))
            .disposed(by: disposeBag)

        viewModel.finishedLoading
            .subscribe(onNext: { _ in print("Finished loading") })
            .disposed(by: disposeBag)
    }
}


func displayErrorAlert(presentedBy presenter: UIViewController) -> ((Error) -> Void) {
    return { error in
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
}
