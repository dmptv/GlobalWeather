//
//  Sub1Contracts.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Foundation

// Module Input
protocol Sub1ModuleInput {
    
}

// Module Output
protocol Sub1ModuleOutput {
    
}

// View Input
protocol Sub1ViewInput: BaseViewInput {
    
}

// View Output
protocol Sub1ViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol Sub1InteractorInput {
    
}

// Interactor Output
protocol Sub1InteractorOutput: AnyObject {
    
}

// Router
protocol Sub1RouterInputProtocol: BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol Sub1RoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol Sub1CoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
