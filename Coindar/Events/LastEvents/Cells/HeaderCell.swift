import UIKit
import CoindarAPI

class HeaderCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: Date) {
        let date = CoindarEvent.Formatters.medium.string(from: title)
        let weekday = CoindarEvent.Formatters.weekdayLong.string(from: title)
        let attributedString = NSMutableAttributedString(string: "\(date), \(weekday)")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSMakeRange(0, date.count + 1))
        titleLabel.attributedText = attributedString
    }
    
}
