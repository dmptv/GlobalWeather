//
//  MultyCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//	
//

import UIKit

class MultyCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol,
               routingHandler: MultyCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = MultyCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
