import UIKit
import CoindarFoundation

protocol MoreCoordinatorDelegate: AnyObject {
    
}

final class MoreCoordinator: Coordinator, MoreCoordinatorDelegate {
    
    private let serviceProvider: ServiceProvider
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(serviceProvider: ServiceProvider,
         navigationController: UINavigationController,
         tabBarController: UITabBarController) {
        self.serviceProvider = serviceProvider
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let viewModel = MoreViewModel(coordinator: self)
        let moreViewController = MoreViewController(viewModel: viewModel)
        tabBarController.viewControllers?.append(moreViewController)
    }
}





