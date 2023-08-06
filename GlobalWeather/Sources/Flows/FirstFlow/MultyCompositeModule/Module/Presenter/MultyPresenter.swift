//
//  MultyPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Foundation

class MultyPresenter: BasePresenter
<MultyModuleOutput,
MultyInteractorInput,
MultyRouterInputProtocol,
MultyViewInput> {
//    var submodule1: Module<Submodule1ModuleInput, Submodule1ModuleOutput>?
//    var submodule2: Module<Submodule2ModuleInput, Submodule2ModuleOutput>?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupSubmodules()
    }
}

// MARK: Private
extension MultyPresenter {
    private func setupSubmodules() {
//        guard let submodule1 = submodule1,
//            let submodule2 = submodule2 else {
//                return
//        }
//        router.showSubmodule1(submodule1)
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
//extension MultyPresenter: Submodule1ModuleOutput {
//    
//}
//
//extension MultyPresenter: Submodule2ModuleOutput {
//    
//}

// MARK: Submodules Routing Handling
//extension MultyPresenter: Submodule1RoutingHandler {
//    func tapSubmodule1ModuleButton() {
//        router.submodule1ButtonRoute()
//    }
//}
//
//extension MultyPresenter: Submodule2RoutingHandler {
//    func tapSubmodule2ModuleButton() {
//        router.submodule2ButtonRoute()
//    }
//}
