// Copyright © lalacode.io All rights reserved.

import CoindarAPI

public class CancellableMock: Cancellable {
    public var isCancelled: Bool = false
    public func cancel() { }
}
