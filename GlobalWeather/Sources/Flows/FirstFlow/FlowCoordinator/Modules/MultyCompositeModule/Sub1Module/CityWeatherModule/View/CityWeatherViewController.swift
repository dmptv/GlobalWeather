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

// MARK: View Input
extension CityWeatherViewController {
    
}

// MARK: Button Action
extension CityWeatherViewController {
    
}
