import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: UI
    var window: UIWindow?
    
    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        
        let root = LastEventsViewController()
        let nav = UINavigationController(rootViewController: root)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        window.rootViewController = nav
        self.window = window
        
        return true
    }
    
    // MARK: Presenting
    func presentAlert(_ alert: UIAlertController) {
        let presentingViewController = self.window?.rootViewController?.presentingViewController ?? self.window?.rootViewController
        presentingViewController?.present(alert, animated: true, completion: nil)
    }
}


