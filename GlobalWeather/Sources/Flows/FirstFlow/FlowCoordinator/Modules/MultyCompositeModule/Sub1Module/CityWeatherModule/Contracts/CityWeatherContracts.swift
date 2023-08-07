//
//  CityWeatherContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//  
//

import Foundation

// Module Input
protocol CityWeatherModuleInput {
    
}

// Module Output
protocol CityWeatherModuleOutput {
    
}

// View Input
protocol CityWeatherViewInput: BaseViewInput {
    
}

// View Output
protocol CityWeatherViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol CityWeatherInteractorInput {
    
}

// Interactor Output
protocol CityWeatherInteractorOutput: AnyObject {
    
}

// Router
protocol CityWeatherRouterInputProtocol: BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol CityWeatherRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol CityWeatherCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
