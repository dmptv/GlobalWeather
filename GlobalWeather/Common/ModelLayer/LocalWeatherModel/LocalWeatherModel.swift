//
//  LocalWeatherModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import Then

class LocalWeatherModel: Codable {
    let locationName: String?
    let latitude: Double?
    let longitude: Double?
    var lastRefreshedDate: Date? = nil
    var weatherData: Data? = nil
    
    init(locationName: String, latitude: Double, longitude: Double) {
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension LocalWeatherModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        LocalWeatherStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = LocalWeatherStoredModel().then { storable  in
            storable.locationName = locationName ?? ""
            storable.latitude = latitude ?? 0
            storable.longitude = longitude ?? 0
            storable.lastRefreshedDate = lastRefreshedDate
            storable.weatherData = weatherData
        }
        return storable
    }
}
