// Copyright © lalacode.io All rights reserved.

public extension UITableView {
    static var standard: UITableView {
        let e = UITableView(frame: .zero, style: .plain)
        e.tableFooterView = UIView()
        return e
    }
}
