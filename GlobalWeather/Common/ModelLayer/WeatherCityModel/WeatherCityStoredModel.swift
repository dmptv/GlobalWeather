//
//  WeatherCityStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import RealmSwift

class WeatherCityStoredModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var coord: WeatherCityCoordStoredModel?
    @objc dynamic var country: String = ""
    @objc dynamic var timezone: Int = 0
    @objc dynamic var population: Int = -1
}

extension WeatherCityStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        WeatherCityModel(id: id,
                         name: name,
                         coord: coord?.createRuntimeModel() as? WeatherCityCoordModel,
                         country: country,
                         timezone: timezone,
                         population: population)
    }  
}
