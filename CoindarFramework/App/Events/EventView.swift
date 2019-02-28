// Copyright © lalacode.io All rights reserved.

import Nuke

final class EventView: UIView {
    private let coinImageView: UIImageView = {
        let e = UIImageView()
        e.snp.makeConstraints({ make in
            make.width.height.equalTo(24)
        })
        return e
    }()

    private let coinLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 1
        return e
    }()

    private let titleLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        e.font = .boldSystemFont(ofSize: 17)
        e.textColor = .link
        return e
    }()

    private let dateLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        return e
    }()

    private let tagChip = Chip()

    private let imageActivityIndicator: UIActivityIndicatorView = {
        let e = UIActivityIndicatorView(style: .gray)
        e.hidesWhenStopped = true
        return e
    }()

    init() {
        super.init(frame: .zero)
        addSubviews(coinImageView, coinLabel, titleLabel, tagChip, dateLabel, imageActivityIndicator)

        coinImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }

        coinLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(coinImageView.snp.trailing).offset(8)
            make.height.greaterThanOrEqualTo(coinImageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinLabel.snp.bottom).offset(8)
            make.leading.equalTo(coinImageView)
            make.trailing.equalToSuperview()
        }

        tagChip.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(tagChip.snp.trailing).offset(4)
            make.bottom.trailing.equalToSuperview()
        }

        imageActivityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(coinImageView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventView: ReusableView {
    func prepareForReuse() {
        coinImageView.image = nil
        coinLabel.text = nil
        titleLabel.text = nil
    }

    func setup(with viewModel: EventViewModel) {
        coinLabel.text = "\(viewModel.coinName) \(viewModel.coinSymbol)"
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.startingDate

        tagChip.setup(with: viewModel.tagName, andBackgroundColor: viewModel.tagStyle.color)

        imageActivityIndicator.startAnimating()
        Nuke.loadImage(with: viewModel.coinImageUrl, into: coinImageView) { [weak imageActivityIndicator] _, _ in
            imageActivityIndicator?.stopAnimating()
        }
    }
}
