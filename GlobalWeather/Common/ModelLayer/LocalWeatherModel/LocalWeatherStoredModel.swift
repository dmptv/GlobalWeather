//
//  LocalWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import RealmSwift

class LocalWeatherStoredModel: Object {
    @objc dynamic var locationName: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    
    @objc dynamic var lastRefreshedDate: Date?
    @objc dynamic var weatherData: Data? = nil
}

extension LocalWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        return LocalWeatherModel(
            locationName: locationName,
            latitude: latitude,
            longitude: longitude)
    }
}
