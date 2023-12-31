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
          print(response.debugDescription)
          switch response.result {
          case .success(let value):
            promise(.success(value))
          case .failure(let afError):
            promise(.failure(CustomAPIError.requestFailed(description: afError.localizedDescription)))
          }
        }
    }
  }
}
