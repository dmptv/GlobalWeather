//
//  RequestBuilder.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Alamofire

class RequestBuilder<R: RouterProtocol> {
    private let BASE_URL = "https://api.openweathermap.org/data/2.5/forecast"
    let API_KEY = "3aeb0927332507b5d1c47e8cccb8c7b9"
  //"3aeb0927332507b5d1c47e8cccb8c7b9" mine
 //"da69ade359c47e35161bf2e2dad374e8"
    
    func buildURLRequest(for route: R) throws -> URLRequest {
        let url = try BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(route.path))
        urlRequest.httpMethod = route.method.rawValue
        
        do {
            try configureParameters(route.parameters, method: route.method, urlRequest: &urlRequest)
        } catch {
            throw error
        }
        
        return urlRequest
    }
    
    private func configureParameters(_ parameters: Parameters?, method: HTTPMethod, urlRequest: inout URLRequest) throws {
        guard let parameters = parameters else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        switch method {
        case .get:
            try configureGetParameters(parameters, urlRequest: &urlRequest)
        case .post:
            try configurePostParameters(parameters, urlRequest: &urlRequest)
        default:
            break
        }
    }
    
    private func configureGetParameters(_ parameters: Parameters, urlRequest: inout URLRequest) throws {
        guard let url = urlRequest.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url
    }
    
    private func configurePostParameters(_ parameters: Parameters, urlRequest: inout URLRequest) throws {
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
    }
}
