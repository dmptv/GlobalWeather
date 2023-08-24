//
//  InfoFeelingsCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//	
//

import UIKit

class InfoFeelingsCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: InfoFeelingsCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = InfoFeelingsCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
