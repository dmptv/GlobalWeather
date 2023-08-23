//
//  HourCollectionView.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023.
//

import UIKit

class HourCollectionView: UICollectionView {
    
    var hoursDataSource: [WeatherViewModel] = []
    
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
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        registerNib(cellType: HourCollectionViewCell.self)
    }
}

extension HourCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hoursDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HourCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.configureCell(viewModel: hoursDataSource[indexPath.item])
        
        return cell
    }
}

extension HourCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.height / 2, height: bounds.height)
    }
}
