//
//  WeatherListModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListModel: Codable {
    let dt: Double
    let main: WeatherListMainResponse
    let weather: [WeatherListWeatherResponse]
    let wind: WeatherListWindResponse?
    let visibility: Int
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
    
    init(dt: Double, main: WeatherListMainResponse, weather: [WeatherListWeatherResponse], wind: WeatherListWindResponse?, visibility: Int, dtTxt: String) {
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
        
    }
}
