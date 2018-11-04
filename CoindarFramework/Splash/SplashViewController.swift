//  Copyright © lalacode.io All rights reserved.

import UIKit
import SnapKit
import CoindarAPI

public class SplashViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let progressView = UIProgressView(progressViewStyle: .default)
        view.addSubview(progressView)

        progressView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }

        _ = Current.coindarApi.getTags(progress: updateProgress(progressView), onSuccess: startApp(_:), onError: displayErrorAlert(presentedBy: self))
    }

    private func startApp(_ tags: [Tag]) -> Void {
        for tag in tags {
            print(tag.name)
        }
    }
}

fileprivate func updateProgress(_ progressView: UIProgressView) -> (Double) -> Void {
    return { progress in
        progressView.progress = Float(progress)
    }
}

func displayErrorAlert(presentedBy presenter: UIViewController) -> (Error) -> Void {
    return { error in
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
}
