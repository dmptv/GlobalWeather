//
//  HourForecastCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//	
//

import UIKit

class HourForecastCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: HourForecastCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = HourForecastCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
