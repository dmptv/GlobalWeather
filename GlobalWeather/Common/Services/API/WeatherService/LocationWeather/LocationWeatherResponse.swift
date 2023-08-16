//
//  LocationWeatherResponse.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

struct LocationWeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: UInt
    let list: [WeatherListResponse]
    let city: WeatherCityResponse
}
