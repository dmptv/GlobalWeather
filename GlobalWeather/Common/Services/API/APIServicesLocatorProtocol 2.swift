//
//  APIServicesLocatorProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Foundation

protocol APIServicesLocatorProtocol {
    func serviceAPIClient() -> WeatherServiceProtocol
}

extension APIServicesLocatorProtocol {
    func serviceAPIClient() -> WeatherServiceProtocol {
        WeatherService()
    }
}
