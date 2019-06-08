// Copyright © lalacode.io All rights reserved.

import SwiftUI

struct EventListView: View {
    @ObjectBinding var store: EventStore

    var body: some View {
        NavigationView {
            List(store.events) { eventViewModel in
                EventView(viewModel: eventViewModel)
                }
                .navigationBarTitle(Text("Events"))
        }
    }

    init(store: EventStore) {
        self.store = store
    }
}
