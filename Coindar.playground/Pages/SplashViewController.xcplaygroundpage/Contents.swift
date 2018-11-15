import PlaygroundSupport
import UIKit
import CoindarFramework
import CoindarAPI
import Moya

class CancellableMock: Cancellable {
    var isCancelled: Bool = false
    func cancel() { }
}

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

class CoindarMock: Coindar {
    override func getCoins(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Coin]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
//        return simulateSuccessRequestWithProgress(1, progress, onSuccess)
        return simulateErrorRequestWithProgress(1, progress, onError)
    }

    override func getTags(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Tag]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
//        return simulateSuccessRequestWithProgress(0.5, progress, onSuccess)
        return simulateErrorRequestWithProgress(0.5, progress, onError)
    }
}

Current.coindar = CoindarMock(token: "")

let viewController = SplashViewController(coordinator: AppCoordinator.init(window: UIWindow()))

PlaygroundPage.current.liveView = viewController
