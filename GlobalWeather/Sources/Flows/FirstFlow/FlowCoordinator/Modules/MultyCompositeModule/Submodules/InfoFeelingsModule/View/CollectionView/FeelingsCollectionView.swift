//
//  FeelingsCollectionView.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023.
//

import UIKit

class FeelingsCollectionView: UICollectionView {
    var viewModel: WeatherInfoViewModel?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

}

extension FeelingsCollectionView {
    private func setupViews() {
        dataSource = self
        delegate = self
        backgroundColor = .clear
        isUserInteractionEnabled = true
        isScrollEnabled = true
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        configureSubViews()
        
    }
    
    private func configureSubViews() {
        register(cellType: FeelingsCollectionViewCell.self)
    }
}

extension FeelingsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.infos.count else {
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeelingsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.configureCell(viewModel: viewModel ?? nil, item: indexPath.item)
        
        return cell
    }
}

extension FeelingsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.height, height: 60)
    }
}
