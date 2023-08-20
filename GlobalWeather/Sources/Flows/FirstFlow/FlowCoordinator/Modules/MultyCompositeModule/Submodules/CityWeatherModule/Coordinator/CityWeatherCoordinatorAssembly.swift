//
//  CityWeatherCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//	
//

import UIKit

class CityWeatherCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: CityWeatherCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = CityWeatherCoordinator(router: router)
//        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
