//
//  APIClientService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Alamofire

protocol APIClientServiceProtocol {
}

class APIClientService: APIClientServiceProtocol {
    
    
    static func cityWeather(cityName: String, completion:@escaping (Result<WeatherResponse, WeatherServiceError>)->Void) {
        
        AF.request(APIRouter.city(name: cityName))
                     .responseDecodable { (response: DataResponse<WeatherResponse>) in
                completion(response.result)
            }
        }
}

