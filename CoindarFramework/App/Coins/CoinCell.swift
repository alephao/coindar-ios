// Copyright © lalacode.io All rights reserved.

import SnapKit
import Nuke
import CoindarAPI

public final class CoinCell: UITableViewCell {

    private let iconImageView: UIImageView = {
        let e = UIImageView()
        e.contentMode = .center
        return e
    }()

    private let coinNameLabel: UILabel = {
        let e = UILabel()
        return e
    }()

    private let coinSymbolLabel: UILabel = {
        let e = UILabel()
        e.textColor = .gray
        return e
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [iconImageView, coinNameLabel, coinSymbolLabel]
            .forEach(contentView.addSubview)

        iconImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(iconImageView.snp.height)
        }

        coinNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }

        coinSymbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinNameLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }

    public func setup(with coin: Coin) {
        self.coinNameLabel.text = coin.name
        self.coinSymbolLabel.text = coin.symbol
        Nuke.loadImage(with: coin.image32, into: iconImageView)
    }
}
