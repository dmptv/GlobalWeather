//
//  WeatherService.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Combine

protocol WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError>
    func fetchWeather(location: LocalWeatherModel) -> Future<CityWeatherModel, CustomAPIError>
}

class WeatherService: WeatherServiceProtocol {
    func cityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError> {
        CityWeatherRequest(cityName: cityName)
            .performRequest()
    }
    
    func fetchWeather(location: LocalWeatherModel) -> Future<CityWeatherModel, CustomAPIError> {
        LocationWeatherRequest(location: location)
            .performRequest()
    }
}

