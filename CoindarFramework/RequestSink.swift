// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import Moya

struct RequestSink<Value> {
    let success: Observable<Value>
    let failure: Observable<Error>
}

extension RequestSink {
    init(_ f: (@escaping (Value) -> Void, @escaping (Error) -> Void) -> Cancellable) {
        let successRelay = PublishRelay<Value>()
        let errorRelay = PublishRelay<Error>()

        _ = f({ value in
            successRelay.accept(value)
        }, { error in
            errorRelay.accept(error)
        })

        success = successRelay.share(replay: 1)
        failure = errorRelay.share(replay: 1)
    }
}
