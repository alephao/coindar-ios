import UIKit

class SubtitleCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()
    
    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor.hex(0xc2c2c2)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let subtitleWrapper = UIView()
        subtitleWrapper.addSubview(subtitleLabel)
        subtitleWrapper.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: subtitleWrapper.leadingAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: subtitleWrapper.topAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: subtitleWrapper.trailingAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: subtitleWrapper.bottomAnchor).isActive = true
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleWrapper])
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        mainStackView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
