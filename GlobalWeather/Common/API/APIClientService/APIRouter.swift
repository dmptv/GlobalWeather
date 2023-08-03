//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

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
        case let .city(cityName):
            return "/q=\(cityName)&APPID=\(APIRouter.API_KEY)&units=metric"
        case let .wheatherBy(location):
            return "/APPID=\(APIRouter.API_KEY)&lat=\(location.latitude)&lon=\(location.longitude)&units=metrics"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
