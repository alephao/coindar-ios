// Copyright © lalacode.io All rights reserved.

import CoindarAPI
import Moya

func simulateSuccessRequestWithProgress<T>(_ timeInterval: TimeInterval, _ progress: @escaping (Double) -> Void, _ onSuccess: @escaping ([T]) -> Void) -> Cancellable {
    var prog: Double = 0

    var timer: Timer?
    timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
        prog += 0.1
        DispatchQueue.main.async {
            if prog >= 1 {
                progress(1)
                onSuccess([])
                timer?.invalidate()
            } else {
                progress(prog)
            }
        }
    }

    return CancellableMock()
}

func simulateErrorRequestWithProgress(_ timeInterval: TimeInterval, _ progress: @escaping (Double) -> Void, _ onError: @escaping (Error) -> Void) -> Cancellable {
    var prog: Double = 0

    var timer: Timer?
    timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
        prog += 0.1
        DispatchQueue.main.async {
            if prog >= 0.5 {
                progress(1)
                onError(MoyaError.requestMapping("Error r r r r"))
                timer?.invalidate()
            } else {
                progress(prog)
            }
        }
    }

    return CancellableMock()
}

public enum ProgressableResponse {
    case progressAndSuccess
    case progressAndError
}

public final class CoindarMock: Coindar {
    var getCoinsResponse: ProgressableResponse
    var getTagsResponse: ProgressableResponse

    public init(getCoinsResponse: ProgressableResponse = .progressAndSuccess,
                getTagsResponse: ProgressableResponse = .progressAndSuccess) {
        self.getCoinsResponse = getCoinsResponse
        self.getTagsResponse = getTagsResponse
        super.init(token: "")
    }

    override public func getCoins(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Coin]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
        switch getCoinsResponse {
        case .progressAndSuccess:
            return simulateSuccessRequestWithProgress(1, progress, onSuccess)
        case .progressAndError:
            return simulateErrorRequestWithProgress(1, progress, onError)
        }
    }

    override public func getTags(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Tag]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
        switch getCoinsResponse {
        case .progressAndSuccess:
            return simulateSuccessRequestWithProgress(0.5, progress, onSuccess)
        case .progressAndError:
            return simulateErrorRequestWithProgress(0.5, progress, onError)
        }
    }
}
