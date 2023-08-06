//
//  Sub1CoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//	
//

import UIKit

class Sub1CoordinatorAssembly: BaseAssemblyProtocol {
    func build(router: CoordinatorRouterProtocol = BaseCoordinatorRouter(),
               routingHandler: Sub1CoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = Sub1Coordinator(router: router)
        coordinator.coordinationExitPoint = routingHandler
        return coordinator
    }
}
