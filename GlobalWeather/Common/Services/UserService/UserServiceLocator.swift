//
//  UserServiceLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol UserServiceLocatorProtocol {
    func userService() -> UserServiceProtocol
}

extension UserServiceLocatorProtocol {
    func userService() -> UserServiceProtocol {
        UserService.shared
    }
}
