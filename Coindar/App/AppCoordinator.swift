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
    
    // TODO: Break this into smaller peaces
    func startMainFlow() {
        let tabBarController = UITabBarController()
        
        let eventsCoordinator = EventsCoordinator(serviceProvider: serviceProvider,
                                                  navigationController: navigationController,
                                                  tabBarController: tabBarController)
        childCoordinators.append(eventsCoordinator)
        navigationController.viewControllers = [tabBarController]
        
        eventsCoordinator.start()
        
        //        tabBarController.viewControllers?.append(<#T##newElement: UIViewController##UIViewController#>)
    }
}

