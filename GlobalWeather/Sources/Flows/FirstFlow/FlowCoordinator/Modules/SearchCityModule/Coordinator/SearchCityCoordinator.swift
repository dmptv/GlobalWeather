//
//  SearchCityCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//	
//

import UIKit

protocol SearchCityCoordinatorProtocol: CoordinatorProtocol {
    
}

class SearchCityCoordinator: BaseCoordinator<SearchCityCoordinatorExitRoutingProtocol>, SearchCityCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = SearchCityAssembly().build(nil, self)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}

extension SearchCityCoordinator: SearchCityRoutingHandlingProtocol {
    
}
