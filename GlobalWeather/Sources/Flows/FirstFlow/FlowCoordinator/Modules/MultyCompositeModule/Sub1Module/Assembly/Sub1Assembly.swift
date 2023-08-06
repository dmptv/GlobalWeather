//
//  Sub1Assembly.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit

typealias Sub1Module = Module<Sub1ModuleInput, Sub1ModuleOutput>

class Sub1Assembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: Sub1ModuleOutput?,
               _ routingHandler: Sub1RoutingHandlingProtocol) -> Sub1Module {
        // View
        let view = Sub1ViewController()
        
        // Interactor
        let interactor = Sub1Interactor()
        
        // Router
        let router = Sub1Router(viewController: view)
        
        // Presenter
        let presenter = Sub1Presenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
