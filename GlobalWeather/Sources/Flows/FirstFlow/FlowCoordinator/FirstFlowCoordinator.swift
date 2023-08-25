//
//  FirstFlowCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//	
//

import UIKit
import Hero

class FirstFlowCoordinator: BaseFlowCoordinator<FirstFlowRoutingExitHandler> {    
    override func start(with option: DeepLinkOptionProtocol?) {
        super.start(with: option)
        startMain()
    }
}

extension FirstFlowCoordinator {
    private func startMain() {
//        let main = MainCoordinatorAssembly().build(router: router, routingHandler: self)
//        main.start()
//        addChild(main)
        
        let subs = MultyCoordinatorAssembly().build(router: router, routingHandler: self)
        subs.start()
        addChild(subs)
    }
}

extension FirstFlowCoordinator: MultyCoordinatorExitRoutingProtocol {
    func performRouteToSearch(_ coordinator: CoordinatorProtocol) {
        let coordinator = SearchCityCoordinatorAssembly().build(routingHandler: self)
        coordinator.start()
        addChild(coordinator)
        guard let toPresent = coordinator.toPresent() else {
            return
        }
        toPresent.hero.isEnabled = true
        toPresent.hero.modalAnimationType =
            .selectBy(presenting: .push(direction: .left),
                      dismissing: .pull(direction: .right))
        router.present(toPresent, style: .fullScreen)
    }
}

extension FirstFlowCoordinator: SearchCityCoordinatorExitRoutingProtocol {
    
}

