// Copyright © lalacode.io All rights reserved.

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import CoindarAPI

public struct EventListView: View {
    @State var events: [EventViewModel] = []

    public var body: some View {
        List(events.identified(by: \.id)) { eventViewModel in
            SUIEventView(viewModel: eventViewModel)
        }
    }

    func fetchEvents()  -> [EventViewModel] {
        return []
    }
}

public final class EventsViewController: UIHostingController<EventListView> {
    private let viewModel: EventsViewModel

    public init(appState: AppState) {
        viewModel = EventsViewModel(appState: appState)
        super.init(rootView: EventListView())
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
