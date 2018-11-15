// Copyright © lalacode.io All rights reserved.

import CoindarAPI
import Moya

public class CancellableMock: Cancellable {
    public var isCancelled: Bool = false
    public func cancel() { }
}
