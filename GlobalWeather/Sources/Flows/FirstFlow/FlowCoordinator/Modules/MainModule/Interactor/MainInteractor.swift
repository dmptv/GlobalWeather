//
//  MainInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Alamofire
import Combine

class MainInteractor {
    private var cancellables = Set<AnyCancellable>()

    typealias ServiceLocatorAlias = APIClientServiceLocator
    final class ServiceLocator: ServiceLocatorAlias {}
    
    weak var output: MainInteractorOutput?
    private let apiClient: APIClientServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        apiClient = serviceLocator.serviceAPIClient()
        
        apiClient.cityWeather(cityName: "Paris")
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
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MainInteractor: MainInteractorInput {
    
}

struct WeatherForecast: Decodable {
    
}
