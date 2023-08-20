//
//  CityWeatherPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//  
//

import Foundation

class CityWeatherPresenter: BasePresenter
<CityWeatherModuleOutput,
CityWeatherInteractorInput,
CityWeatherRouterInputProtocol,
CityWeatherViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

// MARK: Private
extension CityWeatherPresenter {
    
}

// MARK: Module Input
extension CityWeatherPresenter: CityWeatherModuleInput {
    func setData(_ viewModel: CityDataViewModel) {
        view?.configureView(viewModel: viewModel)
    }
}

// MARK: View Output
extension CityWeatherPresenter: CityWeatherViewOutput {
    
}

// MARK: Interactor Output
extension CityWeatherPresenter: CityWeatherInteractorOutput {
    
}
