//
//  InfoFeelingsAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import UIKit

typealias InfoFeelingsModule = Module<InfoFeelingsModuleInput, InfoFeelingsModuleOutput>

class InfoFeelingsAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: InfoFeelingsModuleOutput?) -> InfoFeelingsModule {
        // View
        let view = InfoFeelingsViewController()
        
        // Interactor
        let interactor = InfoFeelingsInteractor()
        
        // Router
        let router = InfoFeelingsRouter(viewController: view)
        
        // Presenter
        let presenter = InfoFeelingsPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
