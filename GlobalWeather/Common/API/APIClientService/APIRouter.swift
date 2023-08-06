//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

protocol APIRouteParameters {
    var parameters: Parameters? { get }
}

extension APIRouteParameters {
    var commonParameters: Parameters {
        [
            "APPID": APIRouter.API_KEY,
            "units": "metric"
        ]
    }
}

enum APIRouter {
    fileprivate static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    fileprivate static let API_KEY = "da69ade359c47e35161bf2e2dad374e8"
    
    case city(name: String)
    case wheatherBy(location: Location)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .city, .wheatherBy:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .city:
            return ""
        case .wheatherBy:
            return ""
        }
    } 
}

extension APIRouter: APIRouteParameters {
    var parameters: Parameters? {
        var combined = commonParameters
        switch self {
        case let .city(cityName):
            combined["q"] = cityName
        case let .wheatherBy(location):
            combined["lat"] = location.latitude
            combined["lon"] = location.longitude
        }
        return combined
    }
}

extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        try configureParameters(parameters, method: method, urlRequest: &urlRequest)
        
        return urlRequest
    }
    
    private func configureParameters(_ parameters: Parameters?, method: HTTPMethod, urlRequest: inout URLRequest) throws {
        guard let parameters = parameters else {
            return
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
        var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
    }
    
    private func configurePostParameters(_ parameters: Parameters, urlRequest: inout URLRequest) throws {
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
    }
}


