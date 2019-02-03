// Copyright © lalacode.io All rights reserved.

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
