// Copyright © lalacode.io All rights reserved.

final class Chip: UIView {
    private static let margins = UIEdgeInsets(vertical: 4, horizontal: 8)

    private let label = UILabel()

    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 4
        layer.masksToBounds = true

        label.textColor = .white

        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Chip.margins)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setup(with text: String, andBackgroundColor backgroundColor: UIColor) {
        label.text = text
        self.backgroundColor = backgroundColor
    }
}
