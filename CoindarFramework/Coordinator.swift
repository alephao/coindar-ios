// Copyright © lalacode.io All rights reserved.

import Foundation

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get }

    func start()
}
