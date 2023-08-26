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
                } else {
                    self.getDataStateSubject.send(.fetchFeaturedCityWeatherData)
                }
            }
            .store(in: &cancellables)
        
        // we have solely localData
        localDataPublisher
            .map { $0.first }
            .compactMap { $0 }
            .combineLatest(self.databaseService.getAll(of: CityWeatherModel.self)
                                .filter { $0.isEmpty }
                                .eraseToAnyPublisher())
            .print("local here")
            .sink { [weak self] localData, _ in
                guard let self = self else {
                    return
                }
                self.getDataStateSubject.send(LocalDataState.fetchLocationWeatherData(localData))
            }
            .store(in: &cancellables)
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
                }, receiveValue: { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.databaseService.removeAll(of: CityWeatherModel.self)
                        .flatMap { self.databaseService.add(objects: [response]) }
                        .sink { _ in
                            promise(.success(response))
                        }
                        .store(in: &cancellables)
                })
                .store(in: &cancellables)
        }
    }
    
    func fetchWeather(location: LocalWeatherModel) -> Future<CityWeatherModel, CustomAPIError> {
        return Future { [weak self] promise in
            guard let self = self else {
                return
            }
            
            self.apiClient.fetchWeather(location: location)
                .sink(receiveCompletion: { receiveCompletion in
                    if case let .failure(error) = receiveCompletion {
                        promise(.failure(error))
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.databaseService.removeAll(of: CityWeatherModel.self)
                        .flatMap { self.databaseService.add(objects: [response]) }
                        .sink { _ in
                            promise(.success(response))
                        }
                        .store(in: &cancellables)
                })
                .store(in: &cancellables)
        }
    }
    
    private func isDataTooOld(from lastRefreshDate: Date) -> Bool {
        let currentDate = Date()
        return currentDate.minutes(from: lastRefreshDate) >= 1 ? true : false // 180
    }
}
