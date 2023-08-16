//
//  CityWeatherResponse.swift
//  GlobalWeather
//
//  Created by Kanat on 03.08.2023.
//

import Foundation

class CityWeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: UInt
    let list: [WeatherListModel]
    let city: WeatherCityModel
}

extension CityWeatherResponse: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        CityWeatherStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        
    }
    
    
}
