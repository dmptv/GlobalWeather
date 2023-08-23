//
//  SummaryDayCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//	
//

import UIKit

class SummaryDayCoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: SummaryDayCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = SummaryDayCoordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
