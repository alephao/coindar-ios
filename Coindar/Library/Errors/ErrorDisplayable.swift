import UIKit

public protocol ErrorDisplayable {
    func display(error: Error, callback: ((UIAlertAction) -> Void)?)
}

extension UIViewController: ErrorDisplayable {
    public func display(error: Error, callback: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: callback)
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIWindow: ErrorDisplayable {
    public func display(error: Error, callback: ((UIAlertAction) -> Void)? = nil) {
        guard let presenter = rootViewController else { return }
        presenter.display(error: error, callback: callback)
    }
}

