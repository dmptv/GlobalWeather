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
    @IBAction func tap(_ sender: Any) {
        output?.subModuleTapped()
    }
}

// MARK: - Configure
extension CityWeatherViewController: CityWeatherViewInput {
    func configureView(viewModel: CityDataViewModel) {
        cityNameLabel.text = viewModel.cityName
        temperatureLabel.text = viewModel.tempOriginal
        weatherDescriptionLabel.text = viewModel.description
    }
}

extension CityWeatherViewController {
    private func setupSubviews() {
        cityNameLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        temperatureLabel.textColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        weatherDescriptionLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    }
}

// MARK: View Input
extension CityWeatherViewController {
    func setCity(name: String) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = name
        }
    }
}

// MARK: Button Action
extension CityWeatherViewController {
    
}
