//
//  HourForecastCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//	
//

protocol HourForecastCoordinatorProtocol: CoordinatorProtocol {
    
}

class HourForecastCoordinator: BaseCoordinator<HourForecastCoordinatorExitRoutingProtocol>, HourForecastCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = HourForecastAssembly().build(nil)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}
