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
    @objc dynamic var main: WeatherListMainModel?
    @objc dynamic var weather: [WeatherListWeatherResponse]?
    @objc dynamic var wind: WeatherListWindResponse?
    @objc dynamic var visibility: Int = 0
    @objc dynamic var dtTxt: String = ""
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
}

extension WeatherListStoredModel: StorableProtocol {
    func createRuntimeModel() -> RunTimeModelProtocol {
        
    }
}
