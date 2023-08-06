//
//  MainRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Combine

class MainRouter: BaseModuleRouter<MainRoutingHandlingProtocol> {
    private var cancellables = Set<AnyCancellable>()

    override init(viewController: ViewControllerProtocol?) {
        super.init(viewController: viewController)
        
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

extension MainRouter: MainRouterInputProtocol {
    
}
