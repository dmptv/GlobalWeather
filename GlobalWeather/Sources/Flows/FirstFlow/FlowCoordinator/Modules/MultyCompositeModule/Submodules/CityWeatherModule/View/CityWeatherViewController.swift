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
    @IBAction func subModuleTapped(_ sender: Any) {
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
