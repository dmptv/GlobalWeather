//
//  MainAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import UIKit

typealias MainModule = Module<MainModuleInput, MainModuleOutput>

class MainAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: MainModuleOutput?,
               _ routingHandler: MainRoutingHandlingProtocol) -> MainModule {
        // View
        let view = MainViewController()
        
        // Interactor
        let interactor = MainInteractor()
        
        // Router
        let router = MainRouter(viewController: view)
        
        // Presenter
        let presenter = MainPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
