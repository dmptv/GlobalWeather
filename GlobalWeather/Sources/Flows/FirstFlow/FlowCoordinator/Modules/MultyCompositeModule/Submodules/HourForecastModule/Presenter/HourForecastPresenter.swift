//
//  HourForecastPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import Foundation
import Combine

class HourForecastPresenter: BasePresenter
<HourForecastModuleOutput,
HourForecastInteractorInput,
HourForecastRouterInputProtocol,
HourForecastViewInput> {
    private var cancellables = Set<AnyCancellable>()
    private(set) var hourDataPublisher = PassthroughSubject<[WeatherViewModel], Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeForModuleInput()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension HourForecastPresenter {
    
}

// MARK: Module Input
extension HourForecastPresenter: HourForecastModuleInput {
    private func subscribeForModuleInput() {
        hourDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vms in
                self?.view?.hourDataPublisher.send(vms)
            }
            .store(in: &cancellables)
    }
}

// MARK: View Output
extension HourForecastPresenter: HourForecastViewOutput {
    
}

// MARK: Interactor Output
extension HourForecastPresenter: HourForecastInteractorOutput {
    
}
