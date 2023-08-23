//
//  UICollectionView.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023.
//

import UIKit

extension UICollectionReusableView: Reusable {}

extension UICollectionView {
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func registerNib<T: UICollectionViewCell>(cellType: T.Type, nibName: String? = nil) {
        let nibNameToUse = nibName ?? cellType.reuseIdentifier
        let nib = UINib(nibName: nibNameToUse, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier)"
            )
        }
        return cell
    }
}
