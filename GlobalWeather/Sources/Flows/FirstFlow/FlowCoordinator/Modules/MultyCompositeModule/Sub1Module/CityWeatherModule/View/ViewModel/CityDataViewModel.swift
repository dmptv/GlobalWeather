//
//  CityDataViewModel.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023.
//

import Foundation

struct CityDataViewModel {
    let cityName: String
    let tempOriginal: String
    let description: String
    
    static func configure(_ model:  CityWeatherModel) -> Self {
        CityDataViewModel(cityName: model.city?.name ?? "Congo",
                          tempOriginal: "\(model.list.first?.main?.temp ?? 12)",
                          description: model.list.first?.weather.first?.description ?? "super")
    }
}
