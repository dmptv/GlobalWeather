//
//  WeatherCityCoordStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class WeatherCityCoordStoredModel: Object {
    @objc dynamic var lat: Double = 0
    @objc dynamic var lon: Double = 0
}

extension WeatherCityCoordStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        return WeatherCityCoordModel(lat: lat, lon: lon)
    }
}
