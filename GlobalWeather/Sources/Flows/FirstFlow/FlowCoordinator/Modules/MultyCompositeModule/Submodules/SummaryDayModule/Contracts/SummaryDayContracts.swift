//
//  SummaryDayContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import Foundation
import Combine

// Module Input
protocol SummaryDayModuleInput {
    var summaryDayPublisher: PassthroughSubject<WeatherDailyViewModel, Never> { get }
}

// Module Output
protocol SummaryDayModuleOutput {
    
}

// View Input
protocol SummaryDayViewInput: BaseViewInput {
    var summaryDayPublisher: PassthroughSubject<WeatherDailyViewModel, Never> { get }
}

// View Output
protocol SummaryDayViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// Interactor Input
protocol SummaryDayInteractorInput {
    
}

// Interactor Output
protocol SummaryDayInteractorOutput: AnyObject {
    
}

// Router
protocol SummaryDayRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol SummaryDayRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol SummaryDayCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
