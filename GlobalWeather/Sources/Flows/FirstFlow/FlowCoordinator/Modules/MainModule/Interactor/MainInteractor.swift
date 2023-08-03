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
        
    }

}

// MARK: Private
extension MainInteractor: MainInteractorInput {
    
}

struct WeatherForecast: Decodable {
    
}
