

import Foundation

struct WeatherDailyViewModel {
    let day: [String]
    let temp_min: [String]
    let temp_max: [String]
    let conditionImage: [String]
    
    init(temp_min: [String], temp_max: [String], conditionImage: [String], day: [String]) {
        self.day = day
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.conditionImage = conditionImage
    }
    
    static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> WeatherDailyViewModel {
        var minTempArray = [String]()
        var maxTempArray = [String]()
        var conditionIDArray = [String]()
        let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.dateWithMonth })
        let keysArray = Array(temporaryDailyDictionary.keys).sorted(by: { $0 < $1 })
        
        temporaryDailyDictionary.forEach { key, value in
            let tempMax = value.max { $0.tempMaxInt < $1.tempMaxInt }
            let tempMin = value.min { $0.tempMinInt < $1.tempMinInt }
            guard let tempMax = tempMax, let tempMin = tempMin else { return }
            
            maxTempArray.append(tempMax.tempMax)
            minTempArray.append(tempMin.tempMin)
            conditionIDArray.append(tempMax.conditionImage)
        }
        
        return WeatherDailyViewModel(temp_min: minTempArray, temp_max: maxTempArray, conditionImage: conditionIDArray, day: keysArray)
    }
}
