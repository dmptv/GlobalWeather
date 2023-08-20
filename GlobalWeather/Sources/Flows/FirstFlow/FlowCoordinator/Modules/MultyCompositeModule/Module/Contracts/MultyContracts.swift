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
    var containerForCitySubmodule: UIView { get }
    var containerForHourSubmodule: UIView { get }
}

// Interactor Input
protocol MultyInteractorInput {
    var getDataStateSubject: PassthroughSubject<LocalDataState, Never> { get }
    
    func retrieveCityWeather()
    func featuredCityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError>
    func fetchWeather(location: LocalWeatherModel) -> Future<LocationWeatherModel, CustomAPIError>
}

// Interactor Output
protocol MultyInteractorOutput: AnyObject {
    
}

// Router
protocol MultyRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    func showCitySubmodule(_ presentable: PresentableProtocol)
    func showHourSubmodule(_ presentable: PresentableProtocol)
    
    func submodule1ButtonRoute()
    func submodule2ButtonRoute()
}

// Routing Handling
protocol MultyRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func citySumboduleButtonRouting()
    func sumbodule2ButtonRouting()
}

// Coordinator Routing Handling
protocol MultyCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
}
