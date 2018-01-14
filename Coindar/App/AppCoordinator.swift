import UIKit
import CoindarFoundation

protocol AppCoordinatorDelegate: class {
    func startMainFlow()
}

final class AppCoordinator: Coordinator, AppCoordinatorDelegate {
    
    let serviceProvider: ServiceProvider
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let nc = UINavigationController(rootViewController: UIViewController())
        nc.isNavigationBarHidden = false
        
        if #available(iOS 11.0, *) {
            nc.navigationBar.prefersLargeTitles = true
        }
        
        return nc
    }()
    
    init(window: UIWindow, serviceProvider: ServiceProvider) {
        self.window = window
        self.serviceProvider = serviceProvider
        
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        startMainFlow()
    }
    
    func startMainFlow() {
        let rootTabBarController = RootTabBarController()
        
        let eventsCoordinator = EventsCoordinator(serviceProvider: serviceProvider,
                                                  navigationController: navigationController,
                                                  tabBarController: rootTabBarController)
        childCoordinators.append(eventsCoordinator)
        
        let moreCoordinator = MoreCoordinator(serviceProvider: serviceProvider,
                                              navigationController: navigationController, tabBarController: rootTabBarController)
        childCoordinators.append(moreCoordinator)
        
        navigationController.viewControllers = [rootTabBarController]
        
        eventsCoordinator.start()
        moreCoordinator.start()
    }
}

