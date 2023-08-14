//
//  MainContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Alamofire
import Combine

// Module Input
protocol MainModuleInput {
    
}

// Module Output
protocol MainModuleOutput {
    
}

// View Input
protocol MainViewInput: BaseViewInput {
    
}

// View Output
protocol MainViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol MainInteractorInput {
    func cityWeather(cityName: String) -> Future<WeatherResponse, AFError>
    func fetchWeather(location: Location) -> Future<WeatherResponse, AFError>
}

// Interactor Output
protocol MainInteractorOutput: AnyObject {
    
}

// Router
protocol MainRouterInputProtocol: BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol MainRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol MainCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}