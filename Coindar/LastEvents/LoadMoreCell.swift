import UIKit

class LoadMoreCell: UITableViewCell {
    
    private let loadMoreLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 17)
        l.textAlignment = .center
        l.textColor = UIColor.Coindar.lightBlue
        l.text = "Load more"
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    
        contentView.addSubview(loadMoreLabel)
        
        loadMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        loadMoreLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        loadMoreLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        loadMoreLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        loadMoreLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

