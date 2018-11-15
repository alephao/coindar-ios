// Copyright © lalacode.io All rights reserved.

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
