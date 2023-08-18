//
//  MultyInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Combine

/// https://developer.apple.com/documentation/mapkit/mapkit_for_appkit_and_uikit/interacting_with_nearby_points_of_interest

class MultyInteractor {
    weak var output: MultyInteractorOutput?
    
    private var cancellables = Set<AnyCancellable>()

    typealias ServiceLocatorAlias = WeatherServiceLocatorProtocol
    final class ServiceLocator: ServiceLocatorAlias {}
    
    private let apiClient: WeatherServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        apiClient = serviceLocator.serviceAPIClient()    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MultyInteractor: MultyInteractorInput {
    func cityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError> {
        apiClient.cityWeather(cityName: cityName)
    }
    
    func fetchWeather(location: Location) -> Future<LocationWeatherModel, CustomAPIError> {
        apiClient.fetchWeather(location: location)
    }
}

/// 1 retrieve data
/// 2 check if the location has been saved
/// 3 if location is nil - fetch cityWeather data, then
/// 4 store data to real and bind data to view
/// 5 if location is not nil, then
/// 6 check if location has been changed from settings, then
/// 7 fetchWeather for location, then
/// 8 store data to real and bind data to view
/// 9 check if data is 3 hour long
/// 10 if  3 hour long - fetchWeather for location,
/// 11 store data to real and bind data to view
/// 12 if less 3 hour - present stored data
