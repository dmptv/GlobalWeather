//
//  LocalWeatherStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import RealmSwift

class LocalWeatherStoredModel: Object {
    @objc dynamic var weatherId: String?
    @objc dynamic var name: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var lastRefreshedDate: Date?
    @objc dynamic var weatherData: Data? = nil
    
    override class func primaryKey() -> String? {
        return "weatherId"
    }
}

extension LocalWeatherStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        return LocalWeatherModel(
            name: name,
            latitude: latitude,
            longitude: longitude)
    }
}
