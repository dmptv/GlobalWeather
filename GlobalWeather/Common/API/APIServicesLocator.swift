//
//  APIServicesLocatorProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol APIServicesLocator {
    func authService() -> AuthServiceProtocol
}

extension APIServicesLocator {
    func authService() -> AuthServiceProtocol {
        AuthService()
    }
}
