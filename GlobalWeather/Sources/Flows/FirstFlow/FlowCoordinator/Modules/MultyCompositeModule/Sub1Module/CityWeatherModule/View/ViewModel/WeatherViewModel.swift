//
//  WeatherViewModel.swift
//  GlobalWeather
//
//  Created by Kanat on 09.08.2023.
//

import Foundation

struct WeatherViewModel {
    let date: String
    let dateWithMonth: String
    let hour: String
    let day: String
    let temp: String
    let tempOriginal: String
    let tempMinInt: Int
    let tempMaxInt: Int
    let tempMin: String
    let tempMax: String
    let description: String
    let feelslike: String
    let humidity: String
    let pressure: String
    let windSpeed: String
    let windDirection: String
    let visibility: String
    let conditionId: Int
    
    var conditionImage: String {
        switch conditionId {
        case 200...299:
            return "thunderstorms"
        case 300...399:
            return "drizzling"
        case 500...599:
            return "raining"
        case 600...699:
            return "snowing"
        case 700...799:
            return "windy"
        case 800:
            return "shine"
        default:
            return "cloudy"
        }
    }
    
    init(dt_txt: String, dateWithMonth: String, hour: String, day: String, temp: String, tempOriginal: String, temp_min: String, temp_max: String, description: String, conditionId: Int, temp_min_int: Int, temp_max_int: Int, feelslike: String, humidity: String, pressure: String, windSpeed: String, windDirection: String, visibility: String) {
        self.date = dt_txt
        self.dateWithMonth = dateWithMonth
        self.hour = hour
        self.day = day
        self.temp = temp
        self.tempOriginal = tempOriginal
        self.tempMinInt = temp_min_int
        self.tempMaxInt = temp_max_int
        self.tempMin = temp_min
        self.tempMax = temp_max
        self.description = description
        self.conditionId = conditionId
        self.feelslike = feelslike
        self.humidity = humidity
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.visibility = visibility
    }
    
    static func getViewModels(with weatherResponse: CityWeatherModel) -> [WeatherViewModel] {
        return weatherResponse.list.map { getViewModel(eachWeather: $0, response: weatherResponse) }
    }
    
    static func getViewModel(eachWeather: WeatherListModel, response: CityWeatherModel) -> WeatherViewModel {
        let timeZone: Int = response.city?.timezone ?? 0
        let date = Date.getddMMYYYYFormat(timestamp: eachWeather.dtTxt, timeZone: timeZone)
        let dateWithMonth = Date.getddMMFormat(timestamp: eachWeather.dtTxt, timeZone: timeZone)
        let hour = Date.getHHFormat(timestamp: eachWeather.dtTxt, timeZone: timeZone)
        let day = Date.getWeekDay(timestamp: eachWeather.dtTxt, timeZone: timeZone)
        
        let tempMain: Double = eachWeather.main?.temp ?? 0
        let tempOriginal = "\(Int(tempMain))"
        let temp = "\(Int(tempMain))°C"
        
        let tempMin: Double = eachWeather.main?.tempMin ?? 0
        let tempMax: Double = eachWeather.main?.tempMax ?? 0
        let temp_min_int = (Int(tempMin))
        let temp_max_int = (Int(tempMax))
        let temp_min = "\(Int(tempMin))°C"
        let temp_max = "\(Int(tempMax))°C"
        
        var description: String = ""
        let feelslike = "\(Int(eachWeather.main?.feelsLike ?? 0))°C"
        let humidity = "\(String(describing: eachWeather.main?.humidity))%"
        let pressure = "\(Int(eachWeather.main?.pressure ?? 0))hPa"
        let windSpeed = "\(Int((eachWeather.wind?.speed ?? 0) * 3.6))km/h"
        let windDirection = (eachWeather.wind?.deg ?? 0).degToCompass()
        let visibility = "\(eachWeather.visibility / 1000)km"
        var conditionId: Int = 800
        
        if let weather = eachWeather.weather.first {
            description = weather.description
            conditionId = weather.id
        }
        
        return WeatherViewModel(dt_txt: date, dateWithMonth: dateWithMonth, hour: hour, day: day, temp: temp, tempOriginal: tempOriginal, temp_min: temp_min, temp_max: temp_max, description: description, conditionId: conditionId, temp_min_int: temp_min_int, temp_max_int: temp_max_int, feelslike: feelslike, humidity: humidity, pressure: pressure, windSpeed: windSpeed, windDirection: windDirection, visibility: visibility)
    }
}
