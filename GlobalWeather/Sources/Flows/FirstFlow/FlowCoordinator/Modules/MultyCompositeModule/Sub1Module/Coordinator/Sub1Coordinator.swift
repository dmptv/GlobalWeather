//
//  Sub1Coordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//	
//

import UIKit

protocol Sub1CoordinatorProtocol: CoordinatorProtocol {
    
}

class Sub1Coordinator: BaseCoordinator<Sub1CoordinatorExitRoutingProtocol>, Sub1CoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = Sub1Assembly().build(nil, self)
        guard let toPresent = module.toPresent() else {
            return
        }
        let navController = UINavigationController(rootViewController: toPresent)
        router.showScreen(navController)
    }
}

extension Sub1Coordinator: Sub1RoutingHandlingProtocol {
    
}
