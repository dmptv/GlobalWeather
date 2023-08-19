//
//  LocationWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class LocationWeatherStoredModel: Object {
    @objc dynamic var cod: String = ""
    @objc dynamic var message: Double = 0
    @objc dynamic var cnt: Int = 0
    var list = List<WeatherListStoredModel>()
    @objc dynamic var city: WeatherCityStoredModel?
}

extension LocationWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        return LocationWeatherModel(
            cod: cod,
            message: message,
            cnt: cnt,
            list: list.compactMap { $0.createRuntimeModel() as? WeatherListModel },
            city: city?.createRuntimeModel() as? WeatherCityModel
        )
    }
}
