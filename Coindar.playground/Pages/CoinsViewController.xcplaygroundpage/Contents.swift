import PlaygroundSupport
import UIKit
import CoindarAPI
import RxSwift
import RxDataSources
import Overture
import Nuke
import SnapKit

let mockURL = URL(string: "https://coindar.org/images/coins/bitcoin/32x32.png")!

extension Coin {
    static let mock = Coin(id: "btc", name: "Bitcoin", symbol: "BTC", image32: mockURL, image64: mockURL)
}

func coinWith(name: String) -> Coin {
    let coin = Coin.mock
    return Coin(id: coin.id, name: name, symbol: coin.symbol, image32: coin.image32, image64: coin.image64)
}

extension Array where Element == Coin {
    static let mock: [Coin] = [
        .mock,
        coinWith(name: "Ethereum"),
        coinWith(name: "Tenzorum"),
        coinWith(name: "Litecoin"),
    ]
}

class CoinCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CoinCell.self)

    private let iconImageView: UIImageView = {
        let e = UIImageView()
        e.contentMode = .center
        return e
    }()

    private let coinNameLabel: UILabel = {
        let e = UILabel()
        return e
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconImageView)
        contentView.addSubview(coinNameLabel)

        iconImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(iconImageView.snp.height)
        }

        coinNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.top.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }

    func setup(with coin: Coin) {
        self.coinNameLabel.text = coin.name
        Nuke.loadImage(with: coin.image32, into: iconImageView)
    }

}

class CoinsViewController: UIViewController {

    let disposeBag = DisposeBag()

    let tableView: UITableView = {
        let e = UITableView(frame: .zero, style: .plain)
        e.tableFooterView = UIView()
        e.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        e.rowHeight = 60
        return e
    }()

    override func loadView() {
        super.loadView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Observable<[Coin]>.from([.mock])
            .bind(to: tableView.rx.items(cellIdentifier: CoinCell.reuseIdentifier, cellType: CoinCell.self)) {
                _, coin, cell in
                cell.setup(with: coin)
        }.disposed(by: disposeBag)
    }

}

let viewController = CoinsViewController()

PlaygroundPage.current.liveView = viewController
