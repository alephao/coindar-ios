// Copyright © lalacode.io All rights reserved.

public class TableViewCell<WrappedView: ReusableView>: UITableViewCell {
    let wrappedView = WrappedView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(wrappedView)
        wrappedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        wrappedView.prepareForReuse()
    }

    public func setup(with viewModel: WrappedView.ViewModel) {
        wrappedView.setup(with: viewModel)
    }
}
