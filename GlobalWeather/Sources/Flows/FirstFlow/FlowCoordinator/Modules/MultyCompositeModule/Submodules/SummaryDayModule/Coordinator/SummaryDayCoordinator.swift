//
//  SummaryDayCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//	
//

import UIKit

protocol SummaryDayCoordinatorProtocol: CoordinatorProtocol {
    
}

class SummaryDayCoordinator: BaseCoordinator<SummaryDayCoordinatorExitRoutingProtocol>, SummaryDayCoordinatorProtocol {
    override func start(with option: DeepLinkOptionProtocol?) {
        let module = SummaryDayAssembly().build(nil)
        guard let toPresent = module.toPresent() else {
            return
        }
        router.showScreen(toPresent)
    }
}

extension SummaryDayCoordinator: SummaryDayRoutingHandlingProtocol {
    
}
