import Foundation

protocol LoadMoreViewModelDelegate: AnyObject, Loadable { }

class LoadMoreViewModel {
    
    weak var delegate: LoadMoreViewModelDelegate?
    
    private(set) var isLoading = false
    
    func startLoading() {
        isLoading = true
        delegate?.startLoading()
    }
    
    func stopLoading() {
        isLoading = false
        delegate?.stopLoading()
    }
    
}
