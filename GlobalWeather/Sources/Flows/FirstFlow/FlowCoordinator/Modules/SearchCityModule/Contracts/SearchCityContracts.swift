//
//  SearchCityContracts.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import Foundation
import Combine

// Module Input
protocol SearchCityModuleInput {
    
}

// Module Output
protocol SearchCityModuleOutput {
    
}

// View Input
protocol SearchCityViewInput: BaseViewInput {
    
}

// View Output
protocol SearchCityViewOutput: ViewOutputProtocol {
    func viewDidLoad()
    func backButtonAction()
    func textDidChange(searchText: String)
    func didSelectTableViewRow(at indexPath: IndexPath)
}

// Interactor Input
protocol SearchCityInteractorInput {
    func setupCompleterDelegate()
    func enterQueryFragment(with searchText: String)
    func saveSelectedLocationData(indexPath: IndexPath)
}

// Interactor Output
protocol SearchCityInteractorOutput: AnyObject {
    
}

// Router
protocol SearchCityRouterInputProtocol: AlertRoutableProtocol, BaseModuleRoutableProtocol {
    
}

// Routing Handling
protocol SearchCityRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    
}

// Coordinator Routing Handling
protocol SearchCityCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    
}
