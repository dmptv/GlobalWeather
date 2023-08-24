//
//  SearchCityContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import Foundation

// Module Input
protocol SearchCityModuleInput {
    
}

// Module Output
protocol SearchCityModuleOutput {
    
}

// View Input
protocol SearchCityViewInput: BaseViewInput {
    
}

// View Output
protocol SearchCityViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol SearchCityInteractorInput {
    
}

// Interactor Output
protocol SearchCityInteractorOutput: AnyObject {
    
}

// Router
protocol SearchCityRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol SearchCityRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol SearchCityCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
