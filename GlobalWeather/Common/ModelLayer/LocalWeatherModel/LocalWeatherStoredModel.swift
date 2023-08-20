//
//  LocalWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import RealmSwift

class LocalWeatherStoredModel: Object {
    @objc dynamic var locationName: String?
    let latitude = RealmProperty<Double?>()
    let longitude = RealmProperty<Double?>()
    
    @objc dynamic var lastRefreshedDate: Date? = nil
    @objc dynamic var weatherData: Data? = nil
}

extension LocalWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        return LocalWeatherModel(
            locationName: locationName,
            latitude: latitude.value,
            longitude: longitude.value,
            lastRefreshedDate: lastRefreshedDate,
            weatherData: weatherData)
    }
}
