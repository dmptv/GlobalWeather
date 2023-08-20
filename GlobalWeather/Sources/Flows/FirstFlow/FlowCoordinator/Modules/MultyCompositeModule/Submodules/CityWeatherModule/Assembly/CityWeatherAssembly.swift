//
//  CityWeatherAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//  
//

import UIKit

typealias CityWeatherModule = Module<CityWeatherModuleInput, CityWeatherModuleOutput>

class CityWeatherAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: CityWeatherModuleOutput?,
               _ routingHandler: CityWeatherRoutingHandlingProtocol) -> CityWeatherModule {
        // View
        let view = CityWeatherViewController()
        
        // Interactor
        let interactor = CityWeatherInteractor()
        
        // Router
        let router = CityWeatherRouter(viewController: view)
        
        // Presenter
        let presenter = CityWeatherPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
