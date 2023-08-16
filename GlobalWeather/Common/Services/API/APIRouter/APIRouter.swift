//
//  APIRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Alamofire

enum APIRouter {
    private static let requestBuilder = RequestBuilder()
    
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
            return APIRouter.requestBuilder.buildParameters(for: self)
        }
    }
}


