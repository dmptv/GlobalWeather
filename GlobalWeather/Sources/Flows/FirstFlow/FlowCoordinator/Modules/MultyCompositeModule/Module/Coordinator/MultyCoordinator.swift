//
//  MultyCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//	
//

import UIKit

protocol MultyCoordinatorProtocol: CoordinatorProtocol {
    
}

class MultyCoordinator: BaseCoordinator<MultyCoordinatorExitRoutingProtocol>, MultyCoordinatorProtocol {
    override func start() {
        let module = MultyAssembly().build(nil, self)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}

extension MultyCoordinator: MultyRoutingHandlingProtocol {
    func summarySumboduleButtonRouting() {
        
    }
    
    func citySumboduleButtonRouting() {

    }

    func hourSumboduleButtonRouting() {

    }
    
    func feelingsSumboduleButtonRouting() {
        
    }
    
    func performRouteToSearch() {
        coordinationExitPoint?.performRouteToSearch(self)
    }
}
