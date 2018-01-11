import UIKit
import SafariServices

class EventDetailsViewController: UIViewController {
 
    private let coinNameLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .boldSystemFont(ofSize: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let eventCaptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 32)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let startOnLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let proofLinkButton: UIButton = {
        let b = UIButton()
        b.setTitle("Proof link", for: .normal)
        b.backgroundColor = UIColor.Coindar.lightBlue
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.layer.cornerRadius = 4
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let viewModel: EventDetailsViewModel
    
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        coinNameLabel.text = viewModel.coinName
        eventCaptionLabel.text = viewModel.eventCaption
        startOnLabel.attributedText = viewModel.startOn
        
        if let _ = viewModel.proofLink {
            proofLinkButton.addTarget(self, action: #selector(openProofLink), for: .primaryActionTriggered)
        } else {
            proofLinkButton.isEnabled = false
            proofLinkButton.setTitle("No proof link available", for: .normal)
            proofLinkButton.backgroundColor = UIColor.hex(0xdddddd)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Event"
        
        view.addSubview(coinNameLabel)
        coinNameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        coinNameLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 16).isActive = true
        coinNameLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        view.addSubview(eventCaptionLabel)
        eventCaptionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        eventCaptionLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 16).isActive = true
        eventCaptionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        view.addSubview(startOnLabel)
        startOnLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        startOnLabel.topAnchor.constraint(equalTo: eventCaptionLabel.bottomAnchor, constant: 16).isActive = true
        startOnLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        view.addSubview(proofLinkButton)
        proofLinkButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        proofLinkButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
        proofLinkButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        proofLinkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc
    func openProofLink() {
        guard let proofLink = viewModel.proofLink else { return }
        let safariViewController = SFSafariViewController(url: proofLink)
        navigationController?.present(safariViewController, animated: true, completion: nil)
    }
    
}
