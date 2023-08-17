//
//  LocationWeatherRequest.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

class LocationWeatherRequest: BaseRequest<WeatherRouter, LocationWeatherModel> {
    init(location: Location) {
        super.init(route: .wheatherBy(location: location))
    }
}
