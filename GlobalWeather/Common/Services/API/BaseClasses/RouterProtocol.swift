//
//  RouterProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Alamofire

protocol RouterProtocol: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
}
