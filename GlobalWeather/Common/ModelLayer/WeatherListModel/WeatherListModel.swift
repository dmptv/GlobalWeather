//
//  WeatherListModel.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class WeatherListModel: Codable {
    let dt: Double
    let main: WeatherListMainModel?
    let weather: [WeatherListWeatherModel]
    let wind: WeatherListWindModel?
    let visibility: Int
    let dtTxt: String  ///timestamp
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
    
    init(dt: Double, main: WeatherListMainModel?, weather: [WeatherListWeatherModel], wind: WeatherListWindModel?, visibility: Int, dtTxt: String) {
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
        let storable = WeatherListStoredModel().then { storable in
            storable.dt = dt
            storable.main = main?.convertToStorable() as? WeatherListMainStorableModel
            weather.forEach {
                guard let item = $0.convertToStorable() as? WeatherListWeatherStoredModel else {
                    return
                }
                storable.weather.append(item)
            }
            
            storable.wind = wind?.convertToStorable() as? WeatherListWindStoredModel
            storable.visibility = visibility
            storable.dtTxt = dtTxt
        }
        return storable
    }
}
