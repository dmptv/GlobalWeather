//
//  WeatherListWindStoredModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

class WeatherListWindStoredModel: Object {
    @objc dynamic var speed: Double = 0
    @objc dynamic var deg: Double = 0
}

extension WeatherListWindStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        WeatherListWindModel(speed: speed, deg: deg)
    }  
}
