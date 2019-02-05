import PlaygroundSupport
import UIKit
import RxSwift
import RxCocoa
import CoindarFramework

final class Cell: UITableViewCell {
    let label: UILabel = {
        let e = UILabel()
        e.numberOfLines = 1
        return e
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        addSubviews(label)

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func setup(with string: String) {
        label.text = string
    }
}


public final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    let items = Driver<[String]>.just(["Hello"])

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let e = UITableView.standard
        e.register(Cell.self)
        e.rowHeight = UITableView.automaticDimension
        return e
    }()

    override public func loadView() {
        super.loadView()
        view = tableView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        items
            .drive(tableView.rx.items(cellIdentifier: Cell.reuseIdentifier, cellType: Cell.self)) {
                _, string, cell in
                cell.setup(with: string)
            }
            .disposed(by: disposeBag)
    }

}

let viewController = ViewController()

PlaygroundPage.current.liveView = viewController
