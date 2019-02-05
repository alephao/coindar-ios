// Copyright © lalacode.io All rights reserved.
import Nuke

final class EventCell: UITableViewCell {
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

    private let imageActivityIndicator: UIActivityIndicatorView = {
        let e = UIActivityIndicatorView(style: .gray)
        e.hidesWhenStopped = true
        return e
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        addSubviews(coinImageView, coinLabel, titleLabel, imageActivityIndicator)

        coinImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }

        coinLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(coinImageView.snp.trailing).offset(8)
            make.height.greaterThanOrEqualTo(coinImageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coinLabel.snp.bottom).offset(8)
            make.leading.equalTo(coinLabel)
            make.trailing.bottom.equalToSuperview().inset(8)
        }

        imageActivityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(coinImageView)
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
        coinLabel.text = "\(viewModel.coinName) \(viewModel.coinSymbol)"
        titleLabel.text = viewModel.title

        imageActivityIndicator.startAnimating()
        Nuke.loadImage(with: viewModel.coinImageUrl, into: coinImageView) { [weak imageActivityIndicator] _, _ in
            imageActivityIndicator?.stopAnimating()
        }
    }
}
