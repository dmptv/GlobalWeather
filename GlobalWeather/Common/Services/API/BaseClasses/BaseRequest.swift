//
//  BaseRequest.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Alamofire
import Combine

class BaseRequest<R: RouterProtocol, T: Decodable> {
    private let route: R
    private let decoder: JSONDecoder

    init(route: R, decoder: JSONDecoder = JSONDecoder()) {
        self.route = route
        self.decoder = decoder
    }

    func performRequest() -> Future<T, CustomAPIError> {
        return Future { [weak self] promise in
            guard let self = self else {
                return
            }
            AF.request(self.route)
                .responseDecodable (decoder: self.decoder) { (response: DataResponse<T, AFError>) in
                    

                    switch response.result {
                    case .success(let value):
                        
                        
                        if let locationWeatherModel = value as? LocationWeatherModel {
                            print("Response:")
                            dump(locationWeatherModel)
                            
                            if let data = response.data,
                               let jsonString = String(data: data, encoding: .utf8) {
                                print("Incoming JSON response:\n", jsonString)
                            }
                        }
                        
                        promise(.success(value))
                    case .failure(let afError):
                        promise(.failure(CustomAPIError.requestFailed(description: afError.localizedDescription)))
                    }
                }
        }
    }
}
