//
//  CommonResponses.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation



struct WeatherListMainResponse: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherListWeatherResponse: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherListWindResponse: Codable {
    let speed: Double
    let deg: Double
}


