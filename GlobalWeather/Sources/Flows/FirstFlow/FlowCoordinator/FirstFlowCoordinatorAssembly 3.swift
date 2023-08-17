//
//  FirstFlowCoordinatorAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//	
//

import UIKit

class FirstFlowCoordinatorAssembly: BaseAssemblyProtocol {
    func build(_ coordinatorRoutingHandler: FirstFlowRoutingExitHandler) -> CoordinatorProtocol {
        let router = BaseCoordinatorRouter()
        let coordinator = FirstFlowCoordinator(router: router)
        coordinator.coordinationExitPoint = coordinatorRoutingHandler
        return coordinator
    }
}
