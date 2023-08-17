//
//  WeatherListWindModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListWindModel: Codable {
    let speed: Double
    let deg: Double
    
    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}

extension WeatherListWindModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherListWindStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        let storable = WeatherListWindStoredModel().then { storable in
            storable.speed = speed
            storable.deg = deg
        }
        return storable
    }
}
