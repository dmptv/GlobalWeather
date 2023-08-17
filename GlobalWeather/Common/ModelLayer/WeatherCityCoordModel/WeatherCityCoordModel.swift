//
//  WeatherCityCoordModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherCityCoordModel: Codable {
    let lat: Double
    let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

extension WeatherCityCoordModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherCityCoordStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = WeatherCityCoordStoredModel()
        storable.lat = lat
        storable.lon = lon
        return storable
    }
}
