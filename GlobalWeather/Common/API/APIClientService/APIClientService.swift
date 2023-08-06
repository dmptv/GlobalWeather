//
//  APIClientService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Alamofire
import Combine

protocol APIClientServiceProtocol {
    func cityWeather(cityName: String) -> Future<WeatherResponse, AFError>
    func fetchWeather(location: Location) -> Future<WeatherResponse, AFError>
}

class APIClientService: APIClientServiceProtocol {
    func cityWeather(cityName: String) -> Future<WeatherResponse, AFError> {
        performRequest(route: .city(name: cityName))
    }
    
    func fetchWeather(location: Location) -> Future<WeatherResponse, AFError> {
        performRequest(route: APIRouter.wheatherBy(location: location))
    }
}
    
extension APIClientService {
    @discardableResult
    private func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T, AFError> {
        return Future { promise in
            AF.request(route)
                .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
    }
}

