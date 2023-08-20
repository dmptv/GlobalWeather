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
    func setData(_ viewModel: CityDataViewModel)
}

// Module Output
protocol CityWeatherModuleOutput {
    
}

// View Input
protocol CityWeatherViewInput: BaseViewInput {
    func configureView(viewModel: CityDataViewModel)
}

// View Output
protocol CityWeatherViewOutput: ViewOutputProtocol {
    func viewDidLoad()
    func subModuleTapped()
}

// Interactor Input
protocol CityWeatherInteractorInput {
    
}

// Interactor Output
protocol CityWeatherInteractorOutput: AnyObject {
    
}

// Router
protocol CityWeatherRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    func subModuleTapped()
}

// Routing Handling
protocol CityWeatherRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func tapCitySubmoduleModuleButton()
}

// Coordinator Routing Handling
protocol CityWeatherCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
