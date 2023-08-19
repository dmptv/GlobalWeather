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

    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupSubmodules()
        
        interactor?.retrieveCityWeather()
            .sink { [weak self] state in
                guard let self = self else {
                    return
                }
                switch state {
                case .noLocalData:
                    self.subsribeForCityWeather(cityName: "Paris")
                case let .hasLocation(location):
                    self.subsribeForFetchWeather(location: location)
                case let .sendLocalData(name):
                    self.subsribeForCityWeather(cityName: name)
                }
            }
            .store(in: &cancellables)
    }
    
    private func subsribeForCityWeather(cityName: String) {
        interactor?.cityWeather(cityName: cityName)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error sendLocalData")
                }
            }, receiveValue: { response in
                print(response.city?.country as Any, "sendLocalData")
            })
            .store(in: &cancellables)
    }
    
    private func subsribeForFetchWeather(location: LocalWeatherModel) {
        interactor?.fetchWeather(location: location)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error hasLocation")
                }
            }, receiveValue: { response in
                print(response.city?.name as Any, "hasLocation")
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
