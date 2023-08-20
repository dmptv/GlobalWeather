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
    func showCitySubmodule(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForCitySubmodule else {
            return
        }
        showSubmodule(presentable, container)
    }
    
    func showHourSubmodule(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForHourSubmodule else {
            return
        }
        showSubmodule(presentable, container)
    }
    
    func submoduleCityButtonRoute() {
        moduleRoutingHandler?.citySumboduleButtonRouting()
    }
    
    func submoduleHourButtonRoute() {
        moduleRoutingHandler?.sumbodule2ButtonRouting()
    }
}
