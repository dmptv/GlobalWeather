//
//  APIServicesLocatorProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Foundation

protocol WeatherServiceLocatorProtocol {
    func serviceAPIClient() -> WeatherServiceProtocol
}

extension WeatherServiceLocatorProtocol {
    func serviceAPIClient() -> WeatherServiceProtocol {
        WeatherService()
    }
}
