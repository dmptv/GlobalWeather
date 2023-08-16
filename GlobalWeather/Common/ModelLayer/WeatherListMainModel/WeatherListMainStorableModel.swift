//
//  WeatherListMainStorableModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import RealmSwift

class WeatherListMainStorableModel: Object {
    @objc dynamic var temp: Double = 0
    @objc dynamic var feelsLike: Double = 0
    @objc dynamic var tempMin: Double = 0
    @objc dynamic var tempMax: Double = 0
    @objc dynamic var pressure: Double = 0
    @objc dynamic var humidity: Int = 0
}

extension WeatherListMainStorableModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        WeatherListMainModel(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity)
    }
}
