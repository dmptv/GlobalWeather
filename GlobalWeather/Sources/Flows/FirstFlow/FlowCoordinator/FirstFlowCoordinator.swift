//
//  FirstFlowCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//	
//

import UIKit

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
    
}
