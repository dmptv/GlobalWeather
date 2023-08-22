//
//  HourCollectionView.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023.
//

import UIKit

class HourCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}


extension HourCollectionView {
    private func setupViews() {
        dataSource = self
        delegate = self
        backgroundColor = .clear
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        registerNib(cellType: HourCollectionViewCell.self)
        
    }
}

extension HourCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HourCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.configureCell(
            viewModel: [
                WeatherViewModel.init(dt_txt: "", dateWithMonth: "", hour: "", day: "", temp: "", tempOriginal: "", temp_min: "", temp_max: "", description: "", conditionId: 1, temp_min_int: 89, temp_max_int: 334, feelslike: "", humidity: "", pressure: "", windSpeed: "", windDirection: "", visibility: "")
            ],
            item: indexPath.item)
        
        
        return cell
    }
}

extension HourCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.height / 2, height: bounds.height)
    }
}
