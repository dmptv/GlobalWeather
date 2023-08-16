//
//  WeatherService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Combine

protocol WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<CityWeatherResponse, CustomAPIError>
    func fetchWeather(location: Location) -> Future<LocationWeatherResponse, CustomAPIError>
}

class WeatherService: WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<CityWeatherResponse, CustomAPIError> {
        CityWeatherRequest(cityName: cityName).performRequest()
    }
    
    func fetchWeather(location: Location) -> Future<LocationWeatherResponse, CustomAPIError> {
        LocationWeatherRequest(location: location).performRequest()
    }
}

