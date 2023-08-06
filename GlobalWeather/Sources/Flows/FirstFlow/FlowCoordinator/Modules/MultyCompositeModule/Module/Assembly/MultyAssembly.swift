//
//  MultyAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit

typealias Multy = Module<MultyModuleInput, MultyModuleOutput>

class MultyAssembly: BaseAssemblyProtocol {
    required init() { }
    
    func build(_ moduleOutput: MultyModuleOutput?, _ routingHandler: MultyRoutingHandlingProtocol) -> Multy {
        // View
        let view = MultyViewController()
        
        // Interactor
        let interactor = MultyInteractor()
        
        // Router
        let router = MultyRouter(viewController: view, containersHolder: view)
        
        // Presenter
        let presenter = MultyPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Submodules
        let submodule1 = Sub1Assembly().build(presenter, presenter)
//
//        let submodule2 = Submodule2ModuleAssembly().build(presenter, presenter)
//
        presenter.submodule1 = submodule1
//        presenter.storyInfoSubmodule = submodule2
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.moduleRoutingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
