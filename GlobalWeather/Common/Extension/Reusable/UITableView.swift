//
//  UITableView.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023.
//

import UIKit

extension UITableViewCell: Reusable {}

extension UITableView {
    final func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier)"
            )
        }
        return cell
    }
}
