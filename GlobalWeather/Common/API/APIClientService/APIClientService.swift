//
//  APIClientService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Alamofire
import Combine

// https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-5-and-codable-part-3-using-futures-promises-cf3977fc8a5

protocol APIClientServiceProtocol {
    func cityWeather(cityName: String, completion: @escaping (Result<WeatherResponse, AFError>) -> Void)
}

class APIClientService: APIClientServiceProtocol {
    func cityWeather(cityName: String, completion: @escaping (Result<WeatherResponse, AFError>) -> Void) {
        performRequest(route: APIRouter.city(name: cityName), completion: completion)
    }
}
    
extension APIClientService {
    @discardableResult
    private func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>) -> Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
    }
}

