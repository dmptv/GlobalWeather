//
//  CityWeatherRequest.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class CityWeatherRequest: BaseRequest<WeatherRouter, CityWeatherResponse> {
    init(cityName: String) {
        super.init(route: .city(name: cityName))
    }
}