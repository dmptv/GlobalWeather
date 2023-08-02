//
//  AppCoordinatorLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

protocol AppCoordinatorServiceLocator {
    func appCoordinator(scene: UIScene) -> CoordinatorProtocol
}

extension AppCoordinatorServiceLocator {
    func appCoordinator(scene: UIScene) -> CoordinatorProtocol {
        AppCoordinator(scene: scene)
    }
}
