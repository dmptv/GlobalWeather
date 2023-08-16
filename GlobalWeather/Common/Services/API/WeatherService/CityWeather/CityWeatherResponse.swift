//
//  CityWeatherResponse.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Foundation

struct CityWeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: UInt
    let list: [WeatherListResponse]
    let city: WeatherCityResponse
}


