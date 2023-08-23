//
//  InfoFeelingsContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import Foundation
import Combine

// Module Input
protocol InfoFeelingsModuleInput {
    var feelingsPublisher: PassthroughSubject<WeatherInfoViewModel, Never> { get }
}

// Module Output
protocol InfoFeelingsModuleOutput {
    
}

// View Input
protocol InfoFeelingsViewInput: BaseViewInput {
    var feelingsPublisher: PassthroughSubject<WeatherInfoViewModel, Never> { get }
}

// View Output
protocol InfoFeelingsViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol InfoFeelingsInteractorInput {
    
}

// Interactor Output
protocol InfoFeelingsInteractorOutput: AnyObject {
    
}

// Router
protocol InfoFeelingsRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol InfoFeelingsRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol InfoFeelingsCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
