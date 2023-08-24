//
//  Reusable.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
