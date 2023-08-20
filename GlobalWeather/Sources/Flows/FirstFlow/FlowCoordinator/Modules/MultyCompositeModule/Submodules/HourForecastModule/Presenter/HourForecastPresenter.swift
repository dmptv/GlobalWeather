//
//  HourForecastPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import Foundation

class HourForecastPresenter: BasePresenter
<HourForecastModuleOutput,
HourForecastInteractorInput,
HourForecastRouterInputProtocol,
HourForecastViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

// MARK: Private
extension HourForecastPresenter {
    
}

// MARK: Module Input
extension HourForecastPresenter: HourForecastModuleInput {
    
}

// MARK: View Output
extension HourForecastPresenter: HourForecastViewOutput {
    
}

// MARK: Interactor Output
extension HourForecastPresenter: HourForecastInteractorOutput {
    
}
