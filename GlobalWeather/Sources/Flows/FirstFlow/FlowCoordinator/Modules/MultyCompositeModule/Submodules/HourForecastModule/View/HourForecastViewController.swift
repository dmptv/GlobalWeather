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
        
        
        hourCollectionView.register(cellType: UICollectionViewCell.self)
        hourCollectionView.dataSource = self
    }
}

extension HourForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UICollectionViewCell.self)
        
        cell.contentView.backgroundColor = .red
        
        return cell
    }
}

extension HourForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.height, height: view.bounds.height)
    }
}

// MARK: View Input
extension HourForecastViewController {
    
}

// MARK: Button Action
extension HourForecastViewController {
    
}
