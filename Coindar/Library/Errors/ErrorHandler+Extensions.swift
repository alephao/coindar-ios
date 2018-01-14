import CoindarFoundation
import UIKit

extension ErrorHandler {
    class var defaultHandler: ErrorHandler {
        return ErrorHandler()
            .on(NetworkingErrorMatcher(), do: { (error) -> MatchingPolicy in
                AppDelegate.shared.window?.display(error: error)
                return .stopMatching
            })
    }
}
