//
//  WeatherListModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListModel: Codable {
    let dt: Double
    let main: WeatherListMainModel
    let weather: [WeatherListWeatherModel]
    let wind: WeatherListWindModel?
    let visibility: Int
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
    
    init(dt: Double, main: WeatherListMainModel, weather: [WeatherListWeatherModel], wind: WeatherListWindModel?, visibility: Int, dtTxt: String) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.wind = wind
        self.visibility = visibility
        self.dtTxt = dtTxt
    }
}

extension WeatherListModel: RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type {
        WeatherListStoredModel.self
    }
    
    func convertToStorable() -> StorableProtocol {
        var storable = WeatherListStoredModel()
        storable.dt = dt
        storable.main = (main.convertToStorable() as? WeatherListMainStorableModel)
        
        storable.weather = weather
        storable.wind = wind
        storable.visibility = visibility
        storable.dtTxt = dtTxt
        return storable
    }
}
