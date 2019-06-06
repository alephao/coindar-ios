// Copyright © lalacode.io All rights reserved.

import UIKit
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

struct EventView : View {
    @ObjectBinding
    var presenter: EventPresenter

    init(viewModel: EventViewModel) {
        self.presenter = EventPresenter(viewModel: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 4) {
                if presenter.loadingImage {
                    CKSpinner(isAnimating: $presenter.loadingImage)
                        .frame(width: 24, height: 24, alignment: .center)
                } else {
                    Image(uiImage: presenter.image)
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .aspectRatio(contentMode: ContentMode.fit)
                }
                Text(presenter.viewModel.coinName)
            }
            Text(presenter.viewModel.title)
            HStack(alignment: .center) {
                CKTagView(presenter.viewModel.tagName, backgroundColor: presenter.viewModel.tagStyle.color)
                Spacer(minLength: 8)
                Text(presenter.viewModel.startingDate)
            }
        }
    }
}
