//  Copyright © lalacode.io All rights reserved.

import UIKit
import Overture
import SnapKit
import CoindarAPI
import RxSwift
import RxCocoa

public final class SplashViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let viewModel = SplashViewModel()

    var finishedLoading: Observable<AppState> {
        return viewModel.finishedLoading
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let progressView = UIProgressView(progressViewStyle: .default)

        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."

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

        viewModel.error
            .map(alertFromError)
            .subscribe(onNext: flip(flip(curry(present))(true))(nil))
            .disposed(by: disposeBag)
    }
}

func alertFromError(_ error: Error) -> UIViewController {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    return alert
}
