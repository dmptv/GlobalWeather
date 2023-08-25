//
//  LocalWeatherModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import Then
import RealmSwift

class LocalWeatherModel: Codable {
    let locationName: String?
    let latitude: Double?
    let longitude: Double?
    
    var lastRefreshedDate: Date?
    var weatherData: Data?
    
    init(locationName: String?, latitude: Double?, longitude: Double?, lastRefreshedDate: Date? = nil, weatherData: Data? = nil) {
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.lastRefreshedDate = lastRefreshedDate
        self.weatherData = weatherData
    }
}

extension LocalWeatherModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        LocalWeatherStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = LocalWeatherStoredModel().then { storable  in
            storable.locationName = locationName
            storable.latitude.value = latitude
            storable.longitude.value = longitude
            storable.lastRefreshedDate = lastRefreshedDate
            storable.weatherData = weatherData
        }
        return storable
    }
}
