//
//  HourForecastContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import Foundation
import Combine

// Module Input
protocol HourForecastModuleInput {
    var hourDataPublisher: PassthroughSubject<[WeatherViewModel], Never> { get }
}

// Module Output
protocol HourForecastModuleOutput {
    func tapHourSubmoduleModuleButton()
}

// View Input
protocol HourForecastViewInput: BaseViewInput {
    var hourDataPublisher: PassthroughSubject<[WeatherViewModel], Never> { get }
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
