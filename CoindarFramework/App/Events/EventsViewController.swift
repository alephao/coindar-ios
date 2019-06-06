// Copyright © lalacode.io All rights reserved.

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import CoindarAPI
import Combine

class EventStore: BindableObject {
    let didChange = PassthroughSubject<EventStore, Never>()

    var events: [EventViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }

    private let disposeBag = DisposeBag()

    init(appState: AppState) {
        let params = EventsParams(page: 1, pageSize: 20, filterDateStart: nil, filterDateEnd: nil, filterCoins: nil, filterTags: nil, sortBy: .dateStart, orderBy: .ascending)
        let sink = Current.coindar.rx.getEventsSink(params: params)

        sink.success.map { events in
            events.zipWith(coins: appState.coins, tags: appState.tags).map(EventViewModel.init)
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] events in
                guard let self = self else { return }
                self.events = events
            })
            .disposed(by: disposeBag)
    }
}

public struct EventListView: View {
    @ObjectBinding var store: EventStore

    public var body: some View {
        NavigationView {
            List(store.events) { eventViewModel in
                EventView(viewModel: eventViewModel)
            }
            .navigationBarTitle(Text("Events"))
        }
    }

    private let disposeBag = DisposeBag()

    init(store: EventStore) {
        self.store = store
    }
}

public final class EventsViewController: UIHostingController<EventListView> {
    public init(appState: AppState) {
        let store = EventStore(appState: appState)
        let root = EventListView(store: store)
        super.init(rootView: root)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
