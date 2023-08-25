//
//  SearchCityPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import Foundation

class SearchCityPresenter: BasePresenter
<SearchCityModuleOutput,
SearchCityInteractorInput,
SearchCityRouterInputProtocol,
SearchCityViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

// MARK: Private
extension SearchCityPresenter {
    
}

// MARK: Module Input
extension SearchCityPresenter: SearchCityModuleInput {
    
}

// MARK: View Output
extension SearchCityPresenter: SearchCityViewOutput {
    func backButtonAction() {
        router?.closeRouting()
    }
}

// MARK: Interactor Output
extension SearchCityPresenter: SearchCityInteractorOutput {
    
}
