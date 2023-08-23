//
//  InfoFeelingsCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//	
//

protocol InfoFeelingsCoordinatorProtocol: CoordinatorProtocol {
    
}

class InfoFeelingsCoordinator: BaseCoordinator<InfoFeelingsCoordinatorExitRoutingProtocol>, InfoFeelingsCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = InfoFeelingsAssembly().build(nil)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}

extension InfoFeelingsCoordinator: InfoFeelingsRoutingHandlingProtocol {
    
}
