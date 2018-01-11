import UIKit
import CoindarAPI

class EventCell: UITableViewCell {
    
    private let eventNameLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .bold)
        return l
    }()
    
    private let eventAddedLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor.hex(0xc2c2c2)
        return l
    }()
    
    private let coinNameLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textAlignment = .right
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor.hex(0xACB7D5)
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let eventStackView = UIStackView(arrangedSubviews: [eventNameLabel, eventAddedLabel])
        eventStackView.axis = .vertical
        eventStackView.spacing = 4
        
        let mainStackView = UIStackView(arrangedSubviews: [eventStackView, coinNameLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        
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
    
    func setup(_ event: CoindarEvent) {
        eventNameLabel.text = event.caption
        
        let eventAddedAttributedString = NSMutableAttributedString(string: "Event added \(event.eventAddedCaption) ago")
        eventAddedAttributedString.addAttribute(.foregroundColor, value: UIColor.hex(0x999999), range: NSRange(location: 12, length: event.eventAddedCaption.count))
        eventAddedLabel.attributedText = eventAddedAttributedString
        
        let coinNameAttributedString = NSMutableAttributedString(string: "\(event.coinName) \(event.coinSymbol)")
        coinNameAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .bold), range: NSRange(location: 0, length: event.coinName.count))
        
        coinNameLabel.attributedText = coinNameAttributedString
    }
    
}
