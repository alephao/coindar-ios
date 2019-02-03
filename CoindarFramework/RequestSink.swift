// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import Moya

public struct RequestSink<Value> {
    public let success: Observable<Value>
    public let failure: Observable<Error>
    public let loading: Driver<Bool>
}

extension RequestSink {
    init(_ f: (@escaping (Value) -> Void, @escaping (Error) -> Void) -> Cancellable) {
        let successRelay = PublishRelay<Value>()
        let errorRelay = PublishRelay<Error>()
        let loadingRelay = BehaviorRelay<Bool>(value: true)

        _ = f({ value in
            successRelay.accept(value)
            loadingRelay.accept(false)
        }, { error in
            errorRelay.accept(error)
            loadingRelay.accept(false)
        })

        success = successRelay.share(replay: 1)
        failure = errorRelay.share(replay: 1)
        loading = loadingRelay.asDriver()
    }
}
