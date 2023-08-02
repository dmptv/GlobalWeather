//
//  APIClientService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Alamofire

protocol APIClientServiceProtocol {
    func makeRequest<T: Decodable>(endpoint: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void)
}

class APIClientService: APIClientServiceProtocol {
    static let shared = APIClientService()
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    static let API_KEY = "da69ade359c47e35161bf2e2dad374e8"
    
    func makeRequest<T: Decodable>(endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL + endpoint
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

