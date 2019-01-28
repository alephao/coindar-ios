// Copyright © lalacode.io All rights reserved.

extension UITableView {
    public static var standard: UITableView {
        let e = UITableView(frame: .zero, style: .plain)
        e.tableFooterView = UIView()
        return e
    }
}
