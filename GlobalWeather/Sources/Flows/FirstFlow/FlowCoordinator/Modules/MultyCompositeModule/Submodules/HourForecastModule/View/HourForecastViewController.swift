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
    
    @IBOutlet weak var hourCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension HourForecastViewController: HourForecastViewInput {
    private func setupSubviews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        hourCollectionView.backgroundColor = .emerald
    }
}

// MARK: View Input
extension HourForecastViewController {
    
}

// MARK: Button Action
extension HourForecastViewController {
    
}
