//
//  LocalWeatherModel.swift
//  GlobalWeather
//
//  Created by Kanat on 18.08.2023.
//

import Foundation
import Then

class LocalWeatherModel: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
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
            storable.name = name
            storable.latitude = latitude
            storable.longitude = longitude
        }
        return storable
    }
}
