//
//  RootRouterLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol RootRouterLocator {
    func rootRouter() -> RootRouter
}

extension RootRouterLocator {
    func rootRouter() -> RootRouter {
        RootRouter()
    }
}
