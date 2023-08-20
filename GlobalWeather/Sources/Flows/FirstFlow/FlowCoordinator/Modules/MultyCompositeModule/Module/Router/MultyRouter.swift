//
//  MultyRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Foundation

class MultyRouter<
    ContainerHolder: MultyContainersHolderProtocol
>: BaseCompositeModuleRouter<ContainerHolder, MultyRoutingHandlingProtocol> {
}

extension MultyRouter: MultyRouterInputProtocol {
    func showSubmodule1(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForCitySubmodule else {
            return
        }
        showSubmodule(presentable, container)
    }
    
    func showSubmodule2(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForSubmodule2 else {
            return
        }
        showSubmodule(presentable, container)
    }
    
    func submodule1ButtonRoute() {
        moduleRoutingHandler?.sumbodule1ButtonRouting()
    }
    
    func submodule2ButtonRoute() {
        moduleRoutingHandler?.sumbodule2ButtonRouting()
    }
}
