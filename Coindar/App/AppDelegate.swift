import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?
    
    private let serviceProvider = ServiceProvider()
    private var appCoordinator: AppCoordinator?
    
    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window,
                                            serviceProvider: serviceProvider)
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        self.window = window
        return true
    }
    
    let copyFeedbackView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        v.layer.cornerRadius = 8
        
        let l = UILabel()
        l.text = "Copied to clipboard"
        l.textColor = .white
        
        v.addSubview(l)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        l.translatesAutoresizingMaskIntoConstraints = false
        
        l.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 16).isActive = true
        l.rightAnchor.constraint(equalTo: v.rightAnchor, constant: -16).isActive = true
        l.topAnchor.constraint(equalTo: v.topAnchor, constant: 16).isActive = true
        l.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16).isActive = true
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func showCopiedFeedback() {
        let v = window!.rootViewController!.view!
        v.addSubview(copyFeedbackView)
        
        copyFeedbackView.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        copyFeedbackView.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        
        self.copyFeedbackView.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.copyFeedbackView.alpha = 0
        }) { finished in
            self.copyFeedbackView.removeFromSuperview()
        }
    }
}


