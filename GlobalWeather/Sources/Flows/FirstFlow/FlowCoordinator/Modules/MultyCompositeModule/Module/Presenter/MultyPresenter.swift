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
    var submodule1: Module<Sub1ModuleInput, Sub1ModuleOutput>?
//    var submodule2: Module<Submodule2ModuleInput, Submodule2ModuleOutput>?
    
    private var cancellables = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupSubmodules()
        
        let locationData = Location(name: "Paris", latitude: 21.2859, longitude: 14.7832)
        interactor?.cityWeather(cityName: locationData.name)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error, "kanat error")
                }
            }, receiveValue: { response in
                print(response, "response kanat")
            })
            .store(in: &cancellables)
        
        interactor?.fetchWeather(location: locationData)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    print("finished location")
                case .failure(let error):
                    print(error, "kanat error location")
                }
            }, receiveValue: { response in
                print(response, "response kanat location")
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
extension MultyPresenter: Sub1ModuleOutput {
    
}

//extension MultyPresenter: Submodule2ModuleOutput {
//    
//}

// MARK: Submodules Routing Handling
extension MultyPresenter: Sub1RoutingHandlingProtocol {
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
