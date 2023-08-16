//
//  WeatherListStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class WeatherListStoredModel: Object {
    @objc dynamic var dt: Double = 0
    @objc dynamic var main: WeatherListMainStorableModel?
    var weather = List<WeatherListWeatherStoredModel>()
    @objc dynamic var wind: WeatherListWindStoredModel?
    @objc dynamic var visibility: Int = 0
    @objc dynamic var dtTxt: String = ""
}

extension WeatherListStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        WeatherListModel(dt: dt,
                         main: main?.createRuntimeModel() as? WeatherListMainModel,
                         weather: weather.compactMap { $0.createRuntimeModel() as? WeatherListWeatherModel },
                         wind: wind?.createRuntimeModel() as? WeatherListWindModel,
                         visibility: visibility,
                         dtTxt: dtTxt)
    }
}
