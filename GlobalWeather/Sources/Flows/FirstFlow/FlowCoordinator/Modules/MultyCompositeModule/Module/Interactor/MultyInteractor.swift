//
//  MultyInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Combine
import Foundation

enum LocalDataState {
    case fetchFeaturedCityWeatherData
    case fetchLocationWeatherData(LocalWeatherModel)
    case presentStoredData(CityWeatherModel, _ name: String)
}

/// https://developer.apple.com/documentation/mapkit/mapkit_for_appkit_and_uikit/interacting_with_nearby_points_of_interest

class MultyInteractor {
    weak var output: MultyInteractorOutput?
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var getDataStateSubject = PassthroughSubject<LocalDataState, Never>()

    typealias ServiceLocatorAlias = WeatherServiceLocatorProtocol & DatabaseServiceLocatorProtocol
    final class ServiceLocator: ServiceLocatorAlias {}
    
    private let apiClient: WeatherServiceProtocol
    private let databaseService: DatabaseServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        apiClient = serviceLocator.serviceAPIClient()
        databaseService = serviceLocator.serviceDatabase()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MultyInteractor: MultyInteractorInput {
    func retrieveCityWeather() {
        let localDataPublisher = databaseService.getAll(of: LocalWeatherModel.self)
            .eraseToAnyPublisher()
            .share()
        
        // if local data is nil
        localDataPublisher
            .map { $0.first }
            .map { localData -> LocalWeatherModel? in
                guard let _ = localData?.locationName,
                      let _ = localData?.latitude,
                      let _ = localData?.longitude
                else {
                    return nil
                }
                return localData
            }
            .filter { $0 == nil }
            .sink { [weak self] localData in
                guard let self = self else {
                    return
                }
                self.getDataStateSubject.send(.fetchFeaturedCityWeatherData)
            }
            .store(in: &cancellables)
        
        // we have localData and weatherData
        localDataPublisher
            .map { $0.first }
            .compactMap { $0 }
            .combineLatest(databaseService.getAll(of: CityWeatherModel.self)
                .map { $0.first }
                .compactMap { $0 }
            )
            .sink { [weak self] localData, cityData in
                guard let self = self else {
                    return
                }
                
                if let lastRefreshDate = localData.lastRefreshedDate,
                   let locationName = localData.locationName {
                    
                    if self.isDataTooOld(from: lastRefreshDate) {
                        self.getDataStateSubject.send(.fetchLocationWeatherData(localData))
                    } else {
                        self.getDataStateSubject.send(.presentStoredData(cityData, locationName))
                    }
                }
                
            }
            .store(in: &cancellables)
    }
    
    
    func retrieveCityWeather2() -> AnyPublisher<LocalDataState, Never> {
        let subject = PassthroughSubject<LocalDataState, Never>()
        
        let completion = BlockObject<[LocalWeatherModel], Void> { [weak self] arr in
            guard let self = self else {
                return
            }
            
            guard let localData = arr.first,
                  let locationName = localData.locationName,
                  let _ = localData.latitude,
                  let _ = localData.longitude
            else {
                subject.send(.fetchFeaturedCityWeatherData)
                return
            }
            
            let localDataCompletion = BlockObject<[CityWeatherModel], Void> { [weak self] arr in
                guard let self = self else {
                    return
                }
                
                if let _ = localData.weatherData,
                   let model = arr.first,
                   let lastRefreshDate = localData.lastRefreshedDate {
                    // All Local Data Exsits

                    if self.isDataTooOld(from: lastRefreshDate) {
                        subject.send(.fetchLocationWeatherData(localData))
                    } else {
                        subject.send(.presentStoredData(model, locationName))
                    }
                       
                } else {
                    // no weather data with new location
                    subject.send(.fetchLocationWeatherData(localData))
                    return
                }
                
            }
            
            self.databaseService.getAll(of: CityWeatherModel.self, completion: localDataCompletion)
        }
        
        self.databaseService.getAll(of: LocalWeatherModel.self, completion: completion)
        return subject.eraseToAnyPublisher()
    }

    
    func featuredCityWeather(cityName: String) -> Future<CityWeatherModel, CustomAPIError> {
        return Future { [weak self] promise in
            guard let self = self else {
                return
            }
            
            self.apiClient.cityWeather(cityName: cityName)
                .sink(receiveCompletion: { receiveCompletion in
                    if case let .failure(error) = receiveCompletion {
                        promise(.failure(error))
                    }
                }, receiveValue: { response in
                    // 4 store data to realm and bind data to view
                    promise(.success(response))
                })
                .store(in: &cancellables)
        }
    }
    
    func fetchWeather(location: LocalWeatherModel) -> Future<LocationWeatherModel, CustomAPIError> {
        apiClient.fetchWeather(location: location)
    }
    
    private func isDataTooOld(from lastRefreshDate: Date) -> Bool {
        let currentDate = Date()
        return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
    }
}

/// 1 retrieve data - V
/// 2 check if the location has been saved - V
/// 3 if location is nil - fetch cityWeather data, then - V
/// 4 store data to realm and bind data to view
/// 5 if location is not nil, then
/// 6 check if location has been changed from settings, then
/// 7 fetchWeather for location, then
/// 8 store data to realm and bind data to view
/// 9 check if data is 3 hour long
/// 10 if  3 hour long - fetchWeather for location,
/// 11 store data to real and bind data to view
/// 12 if less 3 hour - fetch - present stored data
