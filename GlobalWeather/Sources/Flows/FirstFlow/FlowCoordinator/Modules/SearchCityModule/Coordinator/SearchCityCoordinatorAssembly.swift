//
//  SearchCityCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//	
//

import UIKit

class SearchCityCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: SearchCityCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = SearchCityCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
