// Copyright © lalacode.io All rights reserved.

import UIKit
import SwiftUI

final class EventListViewController: UIHostingController<EventListView> {
    init(appState: AppState) {
        let store = EventStore(appState: appState)
        let root = EventListView(store: store)
        super.init(rootView: root)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
