//
//  CityWeatherCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//	
//

import UIKit

protocol CityWeatherCoordinatorProtocol: CoordinatorProtocol {
    
}

class CityWeatherCoordinator: BaseCoordinator<CityWeatherCoordinatorExitRoutingProtocol>, CityWeatherCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = CityWeatherAssembly().build(nil)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}
