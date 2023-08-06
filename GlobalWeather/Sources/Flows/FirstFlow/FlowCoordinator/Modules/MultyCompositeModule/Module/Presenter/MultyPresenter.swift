//
//  MultyPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit

class MultyPresenter: BasePresenter
<MultyModuleOutput,
MultyInteractorInput,
MultyRouterInputProtocol,
MultyViewInput> {
    var submodule1: Module<Sub1ModuleInput, Sub1ModuleOutput>?
//    var submodule2: Module<Submodule2ModuleInput, Submodule2ModuleOutput>?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupSubmodules()
    }
}

// MARK: Private
extension MultyPresenter {
    private func setupSubmodules() {
        guard let submodule1 = submodule1 else {
                return
        }
        router?.showSubmodule1(submodule1)
//        router.showSubmodule2(submodule2)
    }
}

// MARK: Module Input
extension MultyPresenter: MultyModuleInput {

}

// MARK: View Output
extension MultyPresenter: MultyViewOutput {
    
}

// MARK: Interactor Output
extension MultyPresenter: MultyInteractorOutput {
    
}

// MARK: Sumbmodules Outputs
extension MultyPresenter: Sub1ModuleOutput {
    
}

//extension MultyPresenter: Submodule2ModuleOutput {
//    
//}

// MARK: Submodules Routing Handling
extension MultyPresenter: Sub1RoutingHandlingProtocol {
    func performRouteForBackRouting() {
        
    }
    
    func performRouteForCloseRouting() {
        
    }
    
    func performModuleRemovedRouting() {
        
    }
    
    func performRouteForBackOrCloseRouting() {
        
    }
    
    func tapSubmodule1ModuleButton() {
        router?.submodule1ButtonRoute()
    }
}

//extension MultyPresenter: Submodule2RoutingHandler {
//    func tapSubmodule2ModuleButton() {
//        router.submodule2ButtonRoute()
//    }
//}
