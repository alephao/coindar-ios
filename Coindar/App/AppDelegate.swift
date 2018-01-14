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
}


