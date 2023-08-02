//
//  RootRouterLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

protocol RootRouterLocator {
    func rootRouter(scene: UIScene) -> RootRouter
}

extension RootRouterLocator {
    func rootRouter(scene: UIScene) -> RootRouter {
        RootRouter(scene: scene)
    }
}
