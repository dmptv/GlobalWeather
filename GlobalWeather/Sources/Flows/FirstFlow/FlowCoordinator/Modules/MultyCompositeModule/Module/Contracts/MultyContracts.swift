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
    var navigateToSeachSubject: PassthroughSubject<Void, Never> { get }

    
    func viewDidLoad()
}

// View Composite Module Containers Holder
protocol MultyContainersHolderProtocol: ContainersHolderProtocol {
    var containerForCitySubmodule: UIView { get }
    var containerForHourSubmodule: UIView { get }
    var containerForSummarySubmodule: UIView { get }
    var containerForFeelingsSubmodule: UIView { get }
}

// Interactor Input
protocol MultyInteractorInput {
    var getDataStateSubject: PassthroughSubject<LocalDataState, Never> { get }
    
    func retrieveCityWeather()
    func featuredCityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError>
    func fetchWeather(location: LocalWeatherModel) -> Future<CityWeatherModel, CustomAPIError>
}

// Interactor Output
protocol MultyInteractorOutput: AnyObject {
    
}

// Router
protocol MultyRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    var routeToSeachSubject: PassthroughSubject<Void, Never> { get }
    
    func showCitySubmodule(_ presentable: PresentableProtocol)
    func showHourSubmodule(_ presentable: PresentableProtocol)
    func showSummarySubmodule(_ presentable: PresentableProtocol)
    func showFeelingsSubmodule(_ presentable: PresentableProtocol)
    
    func submoduleCityButtonRoute()
    func submoduleHourButtonRoute()
    func submoduleSummaryButtonRoute()
    func submoduleFeelingsButtonRoute()
}

// Routing Handling
protocol MultyRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func citySumboduleButtonRouting()
    func hourSumboduleButtonRouting()
    func summarySumboduleButtonRouting()
    func feelingsSumboduleButtonRouting()
    
    func performRouteToSearch()
}

// Coordinator Routing Handling
protocol MultyCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func performRouteToSearch(_ coordinator: CoordinatorProtocol)
}
