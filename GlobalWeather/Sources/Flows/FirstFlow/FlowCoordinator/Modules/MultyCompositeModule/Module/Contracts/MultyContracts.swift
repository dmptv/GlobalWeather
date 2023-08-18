//
//  MultyContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit
import Combine

// Module Input
protocol MultyModuleInput {
    
}

// Module Output
protocol MultyModuleOutput {
    
}

// View Input
protocol MultyViewInput: BaseViewInput {
    
}

// View Output
protocol MultyViewOutput: ViewOutputProtocol {
    func viewDidLoad()
}

// View Composite Module Containers Holder
protocol MultyContainersHolderProtocol: ContainersHolderProtocol {
    var containerForSubmodule1: UIView { get }
    var containerForSubmodule2: UIView { get }
}

// Interactor Input
protocol MultyInteractorInput {
    func retrieveCityWeather() -> AnyPublisher<LocalDataState, Never>
    func cityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError>
    func fetchWeather(location: LocalWeatherModel) -> Future<LocationWeatherModel, CustomAPIError>
}

// Interactor Output
protocol MultyInteractorOutput: AnyObject {
    
}

// Router
protocol MultyRouterInputProtocol: BaseModuleRoutableProtocol {
    func showSubmodule1(_ presentable: PresentableProtocol)
    func showSubmodule2(_ presentable: PresentableProtocol)
    
    func submodule1ButtonRoute()
    func submodule2ButtonRoute()
}

// Routing Handling
protocol MultyRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func sumbodule1ButtonRouting()
    func sumbodule2ButtonRouting()
}

// Coordinator Routing Handling
protocol MultyCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
}
