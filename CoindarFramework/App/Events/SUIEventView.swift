// Copyright © lalacode.io All rights reserved.

import SwiftUI
import CoindarKit

struct SUIEventView : View {
    let viewModel: EventViewModel

    var body: some View {
        VStack(alignment: .leading) {
            // TODO: Add ImageView for coin logo
            Text(viewModel.coinName)
            Text(viewModel.title)
            HStack(alignment: .center) {
                CKTagView(viewModel.tagName, backgroundColor: viewModel.tagStyle.color)
                Spacer(minLength: 8)
                Text(viewModel.startingDate)
            }
        }
    }
}
