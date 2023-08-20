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
        register(cellType: UICollectionViewCell.self)
    }
}

extension HourCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UICollectionViewCell.self)
        
        cell.contentView.backgroundColor = .red
        
        return cell
    }
}

extension HourCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.height, height: bounds.height)
    }
}
