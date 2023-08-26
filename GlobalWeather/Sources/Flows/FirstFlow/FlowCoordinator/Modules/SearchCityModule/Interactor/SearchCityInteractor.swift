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
        
        search.start { (response, error) in
            guard error == nil else { return }
            guard let placeMark = response?.mapItems[0].placemark else { return }
            guard let locationName = placeMark.name else { return }
             
            let location = LocalWeatherModel(locationName: locationName, latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude)
            // Delete All local data and Save Only Location Data (No Weather Data)
            
//            self.realmManager.saveLocationData(location)
            
            
            
            // go back to RootViewController
//            self.presenter?.popToRootViewController()
        }
    }
    
    func enterQueryFragment(with searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
//            presenter?.reloadTableView()
        }
        searchCompleter.queryFragment = searchText
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension SearchCityInteractor: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
//        presenter?.reloadTableView()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Cancel")
    }
}
