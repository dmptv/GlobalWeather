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

    typealias ServiceLocatorAlias = APIServicesLocatorProtocol
    final class ServiceLocator: ServiceLocatorAlias {}
    
    weak var output: MainInteractorOutput?
    private let apiClient: WeatherServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        apiClient = serviceLocator.serviceAPIClient()    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MainInteractor: MainInteractorInput {
    func cityWeather(cityName: String) -> Future<WeatherResponse, CustomAPIError> {
        apiClient.cityWeather(cityName: cityName)
    }
    
    func fetchWeather(location: Location) -> Future<WeatherResponse, CustomAPIError> {
        apiClient.fetchWeather(location: location)
    }
}

struct WeatherForecast: Decodable {
    
}
