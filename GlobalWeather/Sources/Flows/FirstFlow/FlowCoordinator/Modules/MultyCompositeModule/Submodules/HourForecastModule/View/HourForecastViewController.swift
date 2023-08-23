//
//  HourForecastViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import UIKit
import Combine

class HourForecastViewController: BaseViewController {
    var output: HourForecastViewOutput?
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var hourDataPublisher = PassthroughSubject<[WeatherViewModel], Never>()

    
    @IBOutlet weak var hourCollectionView: HourCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
        
        subscribeForViewInput()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: - Configure
extension HourForecastViewController: HourForecastViewInput {
    private func setupSubviews() {
    } 
}

// MARK: View Input
extension HourForecastViewController {
    private func subscribeForViewInput() {
        hourDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vms in
                self?.hourCollectionView.hoursDataSource = vms
                self?.hourCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: Button Action
extension HourForecastViewController {
    
}
