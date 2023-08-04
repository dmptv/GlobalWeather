//
//  APIClientService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Alamofire

// https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-5-and-codable-part-2-perform-request-and-b5c7ee2e012d

protocol APIClientServiceProtocol {
    func cityWeather(cityName: String, completion:@escaping (Result<WeatherResponse, AFError>) -> Void)
}

class APIClientService: APIClientServiceProtocol {
    func cityWeather(cityName: String, completion:@escaping (Result<WeatherResponse, AFError>) -> Void) {
        
        AF.request(APIRouter.city(name: cityName))
                     .responseDecodable { (response: DataResponse<WeatherResponse, AFError>) in
                         completion(response.result)
            }
        }
}

