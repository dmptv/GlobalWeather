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
    
}

// Module Output
protocol HourForecastModuleOutput {
    
}

// View Input
protocol HourForecastViewInput: BaseViewInput {
    
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
    func tapHourSubmoduleModuleButton()
}

// Coordinator Routing Handling
protocol HourForecastCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
