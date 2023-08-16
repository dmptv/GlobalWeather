//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

enum WeatherRouter: RouterProtocol {
    private static let requestBuilder = RequestBuilder()
    
    case city(name: String)
    case wheatherBy(location: Location)
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
            return WeatherRouter.requestBuilder.buildParameters(for: self)
        }
    }
}


