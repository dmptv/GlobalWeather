//
//  CityWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class CityWeatherStoredModel: Object {
    @objc dynamic var cod: String = ""
    @objc dynamic var message: Double = 0
    @objc dynamic var cnt: UInt = 0
    @objc dynamic var list: [WeatherListStoredModel] = []
    @objc dynamic var city: WeatherCityStoredModel?
}

extension CityWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        
    }
}
