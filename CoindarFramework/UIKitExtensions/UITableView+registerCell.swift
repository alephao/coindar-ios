// Copyright © lalacode.io All rights reserved.

public extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
