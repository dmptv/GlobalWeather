//
//  LocationWeatherModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class LocationWeatherModel: Codable {
    let cod: String
    let message: Double
    let cnt: UInt
    let list: [WeatherListModel]
    let city: WeatherCityModel?
    
    init(cod: String, message: Double, cnt: UInt, list: [WeatherListModel], city: WeatherCityModel?) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

extension LocationWeatherModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        LocationWeatherStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = LocationWeatherStoredModel()
        storable.cod = cod
        storable.message = message
        storable.cnt = cnt
        list.forEach {
            guard let item = $0.convertToStorable() as? WeatherListStoredModel else {
                return
            }
            storable.list.append(item)
        }
        storable.city = city?.convertToStorable() as? WeatherCityStoredModel
        return storable
    }
    
    
}
