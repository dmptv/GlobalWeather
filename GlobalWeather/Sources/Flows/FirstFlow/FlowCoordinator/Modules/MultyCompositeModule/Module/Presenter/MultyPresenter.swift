//
//  MultyPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit
import Combine

class MultyPresenter: BasePresenter
<MultyModuleOutput,
MultyInteractorInput,
MultyRouterInputProtocol,
MultyViewInput> {
    var citySubmodule: Module<CityWeatherModuleInput, CityWeatherModuleOutput>?
    var hourSubmodule: Module<HourForecastModuleInput, HourForecastModuleOutput>?
    
    private var cancellables = Set<AnyCancellable>()
    @FeaturedCityProvider var featuredCity: String
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupSubmodules()
        interactor?.retrieveCityWeather()
        
        interactor?.getDataStateSubject
            .sink { [weak self] state in
                guard let self = self else {
                    return
                }
                switch state {
                case .fetchFeaturedCityWeatherData:
                    self.subsribeForFeaturedCityWeather(self.featuredCity)
                case let .fetchLocationWeatherData(location):
                    self.subsribeForFetchWeather(with: location)
                case .presentStoredData(let model, let city):
                    self.presentData(model, city)
                }
            }
            .store(in: &cancellables)
    }
    
    private func presentData(_ model: CityWeatherModel, _ city: String) {
    }
    
    private func subsribeForFeaturedCityWeather(_ cityName: String) {
        interactor?.featuredCityWeather(cityName: cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error featured")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else {
                    return
                }
                self.citySubmodule?.input.setData(CityDataViewModel.configure(response))
            })
            .store(in: &cancellables)
    }
    
    private func subsribeForFetchWeather(with location: LocalWeatherModel) {
        interactor?.fetchWeather(location: location)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error by location")
                }
            }, receiveValue: { response in
                print(response.city?.name as Any, "by locatiion")
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MultyPresenter {
    private func setupSubmodules() {
        guard let cityModule = citySubmodule,
        let hourModule = hourSubmodule else {
            return
        }
        router?.showCitySubmodule(cityModule)
        router?.showHourSubmodule(hourModule)
    }
}

// MARK: Module Input
extension MultyPresenter: MultyModuleInput {

}

// MARK: View Output
extension MultyPresenter: MultyViewOutput {
    
}

// MARK: Interactor Output
extension MultyPresenter: MultyInteractorOutput {
    
}

// MARK: Sumbmodules Outputs
extension MultyPresenter: CityWeatherModuleOutput {
    func tapCitySubmoduleModuleButton() {
        router?.submoduleCityButtonRoute()
    }
}

extension MultyPresenter: HourForecastModuleOutput {
    
}

// MARK: Submodules Routing Handling
extension MultyPresenter: CityWeatherRoutingHandlingProtocol {
    func performRouteForBackRouting() {
        
    }
    
    func performRouteForCloseRouting() {
        
    }
    
    func performModuleRemovedRouting() {
        
    }
    
    func performRouteForBackOrCloseRouting() {
        
    }
}

extension MultyPresenter: HourForecastRoutingHandlingProtocol {
    func tapHourSubmoduleModuleButton() {
        router?.submoduleHourButtonRoute()
    }
}
