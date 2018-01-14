import UIKit

class DetailCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .bold)
        return l
    }()
    
    private let detailLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor.hex(0xc2c2c2)
        l.textAlignment = .right
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        
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
    
    func setup(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
    
}
