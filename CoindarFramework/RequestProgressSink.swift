// Copyright © lalacode.io All rights reserved.

import RxSwift
import RxCocoa
import Overture
import Moya

public struct RequestProgressSink<Value> {
    private let requestSink: RequestSink<Value>

    public var success: Observable<Value> { return requestSink.success }
    public var failure: Observable<Error> { return requestSink.failure }
    public let progress: Observable<Double>
}

extension RequestProgressSink {
    init(_ f: @escaping (@escaping (Double) -> Void, @escaping (Value) -> Void, @escaping (Error) -> Void) -> Cancellable) {
        let progressRelay = PublishRelay<Double>()

        let progressClosure = { (progress: Double) in
            progressRelay.accept(progress)
        }

        requestSink = progressClosure
            |> curry(f)
            >>> uncurry
            >>> RequestSink<Value>.init
        progress = progressRelay.share(replay: 1)
    }
}
