//
//  SearchCityAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import UIKit

typealias SearchCityModule = Module<SearchCityModuleInput, SearchCityModuleOutput>

class SearchCityAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: SearchCityModuleOutput?,
               _ routingHandler: SearchCityRoutingHandlingProtocol) -> SearchCityModule {
        // View
        let view = SearchCityViewController()
        
        // Interactor
        let interactor = SearchCityInteractor()
        
        // Router
        let router = SearchCityRouter(viewController: view)
        
        // Presenter
        let presenter = SearchCityPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
