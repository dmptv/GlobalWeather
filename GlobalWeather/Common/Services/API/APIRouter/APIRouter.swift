//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

enum APIRouter {
    private static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private static let API_KEY = "da69ade359c47e35161bf2e2dad374e8"
    private static let requestBuilder = RequestBuilder(
        baseURL: APIRouter.baseURL,
        apiKey: APIRouter.API_KEY
    )
    
    private var commonParameters: Parameters {
        [
            "APPID": APIRouter.API_KEY,
            "units": "metric"
        ]
    }
    
    case city(name: String)
    case wheatherBy(location: Location)
}

extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        return try APIRouter.requestBuilder.buildURLRequest(for: self)
    }
}

// MARK: - Private
extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .city, .wheatherBy:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .city, .wheatherBy:
            return ""
        }
    }
    
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


