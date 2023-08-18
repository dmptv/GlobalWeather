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
            .sink(receiveCompletion: { [weak self] receiveCompletion in
                guard let self = self else {
                    return
                }
                
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error) where error == .noLocalData:
                    let locationData = LocalWeatherModel(locationName: "Paris", latitude: 21.2859, longitude: 14.7832)
                    
                    self.interactor?.cityWeather(cityName: locationData.locationName ?? "")
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { response in
                            print(response.city?.country as Any)
                        })
                        .store(in: &self.cancellables)
                    
                case .failure(let error):
                    // Handle other error cases here
                    print(error.localizedDescription)
                }
            },
            receiveValue: { _ in })
            .store(in: &cancellables)






        
        
        let locationData = LocalWeatherModel(locationName: "Paris", latitude: 21.2859, longitude: 14.7832)
        interactor?.cityWeather(cityName: locationData.locationName ?? "")
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error cityName")
                }
            }, receiveValue: { response in
                print(response.city?.country as Any, "cityName")
            })
            .store(in: &cancellables)
        
        interactor?.fetchWeather(location: locationData)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription, "error location")
                }
            }, receiveValue: { response in
                print(response.city?.name as Any, "location")
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
