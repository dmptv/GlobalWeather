//
//  WeatherListWeatherModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListWeatherModel: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

extension WeatherListWeatherModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherListWeatherStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        var storable = WeatherListWeatherStoredModel()
        storable.id = id
        storable.main = main
        storable._description = description
        storable.icon = icon
        return storable
    }
}
