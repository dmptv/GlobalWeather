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
    func showFeelingsSubmodule(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForFeelingsSubmodule else {
            return
        }
        showSubmodule(presentable, container)
    }
    
    func showSummarySubmodule(_ presentable: PresentableProtocol) {
        guard let container = containersHolder?.containerForSummarySubmodule else {
            return
        }
        showSubmodule(presentable, container)
    }
    
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
        moduleRoutingHandler?.hourSumboduleButtonRouting()
    }
    
    func submoduleSummaryButtonRoute() {
        moduleRoutingHandler?.summarySumboduleButtonRouting()
    }
    
    func submoduleFeelingsButtonRoute() {
        
    }
}
