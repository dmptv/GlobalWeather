//
//  WeatherCityModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherCityModel: Codable {
    let id: Int
    let name: String
    let coord: WeatherCityCoordModel?
    let country: String
    let timezone: Int
    let population: Int?
    
    init(id: Int, name: String, coord: WeatherCityCoordModel?, country: String, timezone: Int, population: Int?) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.timezone = timezone
        self.population = population
    }
}

extension WeatherCityModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherCityStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = WeatherCityStoredModel().then { storable in
            storable.id = id
            storable.name = name
            storable.coord = coord?.convertToStorable() as? WeatherCityCoordStoredModel
            storable.country = country
            storable.timezone = timezone
            storable.population = population ?? -1
        }
        return storable
    }  
}
