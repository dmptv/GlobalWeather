//
//  CityWeatherViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 07.08.2023
//  
//

import UIKit

class CityWeatherViewController: BaseViewController {
    var output: CityWeatherViewOutput?
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension CityWeatherViewController: CityWeatherViewInput {
    private func setupSubviews() {
        
    }
}

extension CityWeatherViewController {
    func configureView(viewModel: [WeatherViewModel], cityName: String) {
        guard let recentData = viewModel.first else { return }
        cityNameLabel.text = cityName
        temperatureLabel.text = recentData.tempOriginal
        weatherDescriptionLabel.text = recentData.description
    }
}

// MARK: View Input
extension CityWeatherViewController {
    
}

// MARK: Button Action
extension CityWeatherViewController {
    
}
