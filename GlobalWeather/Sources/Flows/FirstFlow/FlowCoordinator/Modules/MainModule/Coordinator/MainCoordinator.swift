//
//  MainCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//	
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol { }

class MainCoordinator: BaseCoordinator<MainCoordinatorExitRoutingProtocol>, MainCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = MainAssembly().build(nil, self)
        guard let toPresent = module.toPresent() else {
            return
        }
        let navController = UINavigationController(rootViewController: toPresent)
        router.showScreen(navController)
    }
}

extension MainCoordinator: MainRoutingHandlingProtocol {
    
}
