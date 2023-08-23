//
//  HourForecastViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023
//  
//

import UIKit

class HourForecastViewController: BaseViewController {
    var output: HourForecastViewOutput?
    
    @IBOutlet weak var hourCollectionView: HourCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension HourForecastViewController: HourForecastViewInput {
    private func setupSubviews() {
    }
}



// MARK: View Input
extension HourForecastViewController {
    func setupUIBinding(with viewModels: [WeatherViewModel]) {
        DispatchQueue.main.async {
            self.hourCollectionView.hoursDataSource = viewModels
            self.hourCollectionView.reloadData()
        }
    }
}

// MARK: Button Action
extension HourForecastViewController {
    
}
