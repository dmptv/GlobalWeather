//
//  HourForecastAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import UIKit

typealias HourForecastModule = Module<HourForecastModuleInput, HourForecastModuleOutput>

class HourForecastAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: HourForecastModuleOutput?,
               _ routingHandler: HourForecastRoutingHandlingProtocol?) -> HourForecastModule {
        // View
        let view = HourForecastViewController()
        
        // Interactor
        let interactor = HourForecastInteractor()
        
        // Router
        let router = HourForecastRouter(viewController: view)
        
        // Presenter
        let presenter = HourForecastPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
