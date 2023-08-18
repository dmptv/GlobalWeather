//
//  MainPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Combine

class MainPresenter: BasePresenter
<MainModuleOutput,
MainInteractorInput,
MainRouterInputProtocol,
MainViewInput> {
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationData = LocalWeatherModel(name: "Paris", latitude: 21.2859, longitude: 14.7832)
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
extension MainPresenter {
    
}

// MARK: Module Input
extension MainPresenter: MainModuleInput {
    
}

// MARK: View Output
extension MainPresenter: MainViewOutput {
    
}

// MARK: Interactor Output
extension MainPresenter: MainInteractorOutput {
    
}
