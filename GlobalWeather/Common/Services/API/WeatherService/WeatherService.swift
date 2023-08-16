//
//  WeatherService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Combine

protocol WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<WeatherResponse, CustomAPIError>
    func fetchWeather(location: Location) -> Future<WeatherResponse, CustomAPIError>
}

class WeatherService: WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<WeatherResponse, CustomAPIError> {
        CityWeatherRequest(cityName: cityName).performRequest()
    }
    
    func fetchWeather(location: Location) -> Future<WeatherResponse, CustomAPIError> {
        LocationWeatherRequest(location: location).performRequest()
    }
}

