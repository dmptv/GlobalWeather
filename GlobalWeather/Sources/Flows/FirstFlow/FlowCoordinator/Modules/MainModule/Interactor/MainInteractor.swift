//
//  MainInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Alamofire

class MainInteractor {
    typealias ServiceLocatorAlias = APIClientServiceLocator
    
    final class ServiceLocator: ServiceLocatorAlias {}
    
    weak var output: MainInteractorOutput?
    private let apiClient: APIClientServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        apiClient = serviceLocator.serviceAPIClient()
        
        apiClient.cityWeather(cityName: "Paris") { result in
            switch result {
            case let .success(weather):
                print(weather)
            case let .failure(error):
                print(error)
            }
        }
    }

}

// MARK: Private
extension MainInteractor: MainInteractorInput {
    
}

struct WeatherForecast: Decodable {
    
}
