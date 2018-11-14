import PlaygroundSupport
import UIKit
import CoindarFramework
import CoindarAPI
import Moya

class CancellableMock: Cancellable {
    var isCancelled: Bool = false
    func cancel() { }
}

func simulateRequestWithProgress<T>(_ timeInterval: TimeInterval, _ progress: @escaping (Double) -> Void, _ onSuccess: @escaping ([T]) -> Void) -> Cancellable {
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
                print(prog)
                progress(prog)
            }
        }
    }

    return CancellableMock()
}

class CoindarMock: Coindar {
    override func getCoins(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Coin]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
        return simulateRequestWithProgress(1, progress, onSuccess)
    }

    override func getTags(progress: @escaping (Double) -> Void, onSuccess: @escaping ([Tag]) -> Void, onError: @escaping (Error) -> Void) -> Cancellable {
        return simulateRequestWithProgress(0.5, progress, onSuccess)
    }
}

Current.coindar = CoindarMock(token: "")

let viewController = SplashViewController(coordinator: AppCoordinator.init(window: UIWindow()))

PlaygroundPage.current.liveView = viewController
