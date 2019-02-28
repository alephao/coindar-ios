// Copyright © lalacode.io All rights reserved.

public protocol ReusableView where Self: UIView {
    associatedtype ViewModel
    init()
    func prepareForReuse()
    func setup(with viewModel: ViewModel)
}
