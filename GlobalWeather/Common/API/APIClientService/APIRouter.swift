//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

// https://api.openweathermap.org/data/2.5/forecast?
// q=Paris&
// APPID=da69ade359c47e35161bf2e2dad374e8&
// units=metric

enum APIRouter: URLRequestConvertible {
    private static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private static let API_KEY = "da69ade359c47e35161bf2e2dad374e8"
    
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
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case let .city(cityName):
            return [
                "q": cityName,
                "APPID": APIRouter.API_KEY,
                "units": "metric"
            ]
        case let .wheatherBy(location):
            return [
                "APPID": APIRouter.API_KEY,
                "lat": location.latitude,
                "lon": location.longitude,
                "units": "metric"
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL()
        var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        
        // Add query items to URL if parameters exist
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents?.url else {
            throw AFError.invalidURL(url: "")
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
