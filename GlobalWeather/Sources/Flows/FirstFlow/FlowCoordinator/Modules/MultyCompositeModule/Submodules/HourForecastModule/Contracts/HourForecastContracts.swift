//
//  HourForecastContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import Foundation

// Module Input
protocol HourForecastModuleInput {
    func setHourData(_ viewModels: [WeatherViewModel])

}

// Module Output
protocol HourForecastModuleOutput {
    func tapHourSubmoduleModuleButton()
}

// View Input
protocol HourForecastViewInput: BaseViewInput {
    func setupUIBinding(with viewModel: [WeatherViewModel]) 
}

// View Output
protocol HourForecastViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol HourForecastInteractorInput {
    
}

// Interactor Output
protocol HourForecastInteractorOutput: AnyObject {
    
}

// Router
protocol HourForecastRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol HourForecastRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol HourForecastCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
