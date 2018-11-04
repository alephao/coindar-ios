//  Copyright © lalacode.io All rights reserved.

import UIKit
import SnapKit

public class LoadingViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let progressView = UIProgressView(progressViewStyle: .default)
        view.addSubview(progressView)

        progressView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
    }

}
