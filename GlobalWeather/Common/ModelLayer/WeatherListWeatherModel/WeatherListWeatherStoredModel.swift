//
//  WeatherListWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class WeatherListWeatherStoredModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var main: String = ""
    @objc dynamic var _description: String = ""
    @objc dynamic var icon: String = ""
}

extension WeatherListWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        WeatherListWeatherModel(id: id, main: main, description: _description, icon: icon)
    }
}
