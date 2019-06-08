// Copyright © lalacode.io All rights reserved.

import SwiftUI
import CoindarKit
import Combine

final class EventPresenter: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()

    let viewModel: EventViewModel

    var loadingImage: Bool {
        didSet {
            self.didChange.send(())
        }
    }

    var image: UIImage {
        didSet {
            self.didChange.send(())
        }
    }

    init(viewModel: EventViewModel) {
        self.viewModel = viewModel

        loadingImage = true
        image = UIImage()

        fetchImage()
    }

    private func fetchImage() {
        let dataTask = URLSession.shared.dataTask(with: viewModel.coinImageUrl) { data, _ , _ in
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            DispatchQueue.main.async {
                self.loadingImage = false
            }
        }

        dataTask.resume()
    }
}
