import UIKit

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    var childCoordinators: [Coordinator] { get }
    
    func start()
}
