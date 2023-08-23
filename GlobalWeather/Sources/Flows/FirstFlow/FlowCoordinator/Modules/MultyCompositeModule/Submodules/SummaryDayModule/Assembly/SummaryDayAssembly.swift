//
//  SummaryDayAssembly.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import UIKit

typealias SummaryDayModule = Module<SummaryDayModuleInput, SummaryDayModuleOutput>

class SummaryDayAssembly: BaseAssemblyProtocol {
    func build(_ moduleOutput: SummaryDayModuleOutput?) -> SummaryDayModule {
        // View
        let view = SummaryDayViewController()
        
        // Interactor
        let interactor = SummaryDayInteractor()
        
        // Router
        let router = SummaryDayRouter(viewController: view)
        
        // Presenter
        let presenter = SummaryDayPresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
