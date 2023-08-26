//
//  SearchCityPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import Foundation
import Combine

class SearchCityPresenter: BasePresenter
<SearchCityModuleOutput,
SearchCityInteractorInput,
SearchCityRouterInputProtocol,
SearchCityViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.setupCompleterDelegate()
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
    func didSelectTableViewRow(at indexPath: IndexPath) {
        interactor?.saveSelectedLocationData(indexPath: indexPath)
    }
    
    func backButtonAction() {
        router?.closeRouting()
    }
    
    func textDidChange(searchText: String) -> Future<Void, Never>? {
        interactor?.enterQueryFragment(with: searchText)
    }
}

// MARK: Interactor Output
extension SearchCityPresenter: SearchCityInteractorOutput {
    func updateSearchResults(_ results: [String]) {
        view?.updateSearchResults(results)
    }
}
