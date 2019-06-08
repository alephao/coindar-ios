// Copyright © lalacode.io All rights reserved.

import UIKit
import SwiftUI
import CoindarKit
import Combine

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
