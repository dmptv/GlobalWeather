//
//  MainCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//	
//

import UIKit

class MainCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: MainCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = MainCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
