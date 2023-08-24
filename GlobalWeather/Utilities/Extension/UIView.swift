//
//  UIView.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
