//
//  SearchCityInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import MapKit
import Foundation
import Combine

class SearchCityInteractor: NSObject {
    typealias ServiceLocatorAlias = WeatherServiceLocatorProtocol & DatabaseServiceLocatorProtocol
    final class ServiceLocator: ServiceLocatorAlias {}
    
    weak var output: SearchCityInteractorOutput?
    private var cancellables = Set<AnyCancellable>()
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()
    private let databaseService: DatabaseServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        databaseService = serviceLocator.serviceDatabase()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension SearchCityInteractor: SearchCityInteractorInput {
    func setupCompleterDelegate() {
        searchCompleter.delegate = self
    }
    
    func saveSelectedLocationData(indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [weak self] (response, error) in
            guard let self = self,
                  error == nil else {
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else { return }
            guard let locationName = placeMark.name else { return }
             
            let location = LocalWeatherModel(locationName: locationName, latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude)
            self.databaseService.removeAll(of: CityWeatherModel.self)
                .flatMap { self.databaseService.removeAll(of: LocalWeatherModel.self) }
                .flatMap { self.databaseService.add(objects: [location]) }
                .sink { [weak self] _ in
                    self?.output?.navigateRouteToMain()
                }
                .store(in: &cancellables)
        }
    }
    
    func enterQueryFragment(with searchText: String) -> Future<Void, Never> {
        let future: Future<Void, Never> = Future { [weak self] promise in
            if searchText.isEmpty {
                self?.searchResults.removeAll()
                promise(.success(()))
            }
            self?.searchCompleter.queryFragment = searchText
        }
        return future
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension SearchCityInteractor: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        Just(searchResults.map { $0.title })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in
                self?.output?.updateSearchResults(results)
            }
            .store(in: &cancellables)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("👻 Cancel")
    }
}
