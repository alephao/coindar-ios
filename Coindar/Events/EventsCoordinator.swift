import UIKit
import CoindarFoundation
import CoindarAPI
import SafariServices

protocol LastEventsCoordinatorDelegate: AnyObject {
    func showEventDetails(for event: CoindarEvent)
}

protocol EventDetailsCoordinatorDelegate: AnyObject {
    func showSafariView(url: URL)
}

typealias EventsCoordinatorDelegate = LastEventsCoordinatorDelegate & EventDetailsCoordinatorDelegate

final class EventsCoordinator: Coordinator, EventsCoordinatorDelegate {
    
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
        let viewModel = LastEventsViewModel(coindarService: serviceProvider.coindarService,
                                            coordinator: self)
        let lastEventsViewController = LastEventsViewController(viewModel: viewModel)
        viewModel.delegate = lastEventsViewController
        tabBarController.viewControllers = [lastEventsViewController]
    }
    
    func showEventDetails(for event: CoindarEvent) {
        let viewModel = EventDetailsViewModel(event: event,
                                              coordinator: self)
        let eventDetailsViewController = EventDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(eventDetailsViewController, animated: true)
    }
    
    func showSafariView(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true, completion: nil)
    }
}




