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
    var submodule1: Module<CityWeatherModuleInput, CityWeatherModuleOutput>?
//    var submodule2: Module<Submodule2ModuleInput, Submodule2ModuleOutput>?
    
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
                self.submodule1?.input.setData(data: response.city?.name ?? "Not known city")
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
        guard let submodule1 = submodule1 else {
                return
        }
        router?.showSubmodule1(submodule1)
//        router.showSubmodule2(submodule2)
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
    
}

//extension MultyPresenter: Submodule2ModuleOutput {
//    
//}

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
    
    func tapSubmodule1ModuleButton() {
        router?.submodule1ButtonRoute()
    }
}

//extension MultyPresenter: Submodule2RoutingHandler {
//    func tapSubmodule2ModuleButton() {
//        router.submodule2ButtonRoute()
//    }
//}
