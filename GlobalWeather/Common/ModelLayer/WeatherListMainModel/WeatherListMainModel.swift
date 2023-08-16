//
//  WeatherListMainModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListMainModel: Codable {
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
    
    init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Double, humidity: Int) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
}

extension WeatherListMainModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherListMainStorableModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        var storable = WeatherListMainStorableModel()
        storable.temp = temp
        storable.feelsLike = feelsLike
        storable.tempMin = tempMin
        storable.tempMax = tempMax
        storable.pressure = pressure
        storable.humidity = humidity
        return storable
    }
}
