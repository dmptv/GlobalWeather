//
//  AppCoordinatorServiceLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol AppCoordinatorServiceLocator {
    func appCoordinator() -> CoordinatorProtocol
}

extension AppCoordinatorServiceLocator {
    func appCoordinator() -> CoordinatorProtocol {
        AppCoordinator()
    }
}
