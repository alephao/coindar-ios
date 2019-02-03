// Copyright © lalacode.io All rights reserved.

final class EventCell: UICollectionViewCell {
    let coinImageView: UIImageView = {
        let e = UIImageView()
        e.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        return e
    }()

    let coinLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 1
        return e
    }()

    let titleLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        return e
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(coinImageView, coinLabel, titleLabel)

        coinImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }

        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        coinImageView.image = nil
        coinLabel.text = nil
        titleLabel.text = nil
    }

    func setup(with viewModel: EventViewModel) {

        coinLabel.text = viewModel.coinName
        titleLabel.text = viewModel.title
    }
}
