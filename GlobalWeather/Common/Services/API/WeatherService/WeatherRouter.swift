//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

enum WeatherRouter: RouterProtocol {
    private static let requestBuilder = RequestBuilder<WeatherRouter>()
    
    case city(name: String)
    case wheatherBy(location: LocalWeatherModel)
}

extension WeatherRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        return try WeatherRouter.requestBuilder.buildURLRequest(for: self)
    }
}

// MARK: - Private
extension WeatherRouter {
    var method: HTTPMethod {
        get {
            switch self {
            case .city, .wheatherBy:
                return .get
            }
        }
    }
    
    var path: String {
        get {
            switch self {
            case .city, .wheatherBy:
                return ""
            }
        }
    }
    
    var parameters: Parameters {
        get {
            return buildParameters(apiKey: WeatherRouter.requestBuilder.API_KEY)
        }
    }
    
    private func buildParameters(apiKey: String) -> Parameters {
        var parameters: Parameters = [
            "APPID": apiKey,
            "units": "metric"
        ]
        
        switch self {
        case let .city(cityName):
            parameters["q"] = cityName
        case let .wheatherBy(location):
            parameters["lat"] = location.latitude
            parameters["lon"] = location.longitude
        }
        
        return parameters
    }
}


