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
        
        fetchWeatherForecast()
    }
    
    func fetchWeatherForecast() {
            let parameters: Parameters = [
                "q": "Paris",
                "units": "metric",
                "APPID": "da69ade359c47e35161bf2e2dad374e8"
            ]
            
        apiClient.makeRequest(endpoint: "", method: .get, parameters: parameters, headers: nil) { (result: Result<WeatherForecast, Error>) in
                switch result {
                case .success(let weatherData):
                    // Handle weather data
                    print("Temperature in Paris: \(weatherData)")
                case .failure(let error):
                    // Handle error
                    print("Error fetching weather forecast: \(error)")
                }
            }
        }

}

// MARK: Private
extension MainInteractor: MainInteractorInput {
    
}

struct WeatherForecast: Decodable {
    
}
