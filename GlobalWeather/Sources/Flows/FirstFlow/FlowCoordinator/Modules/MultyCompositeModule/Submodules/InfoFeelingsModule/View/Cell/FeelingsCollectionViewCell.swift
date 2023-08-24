//
//  FeelingsCollectionViewCell.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023.
//

import UIKit
import Then

class FeelingsCollectionViewCell: UICollectionViewCell {
    
    private lazy var topLabel = UILabel().then {
        $0.textAlignment = .center
    }
    private lazy var bottomLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private let subInfoTitles = ["Feels like", "Humidity", "Pressure", "Wind Speed", "Wind Direction", "Visibility"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([topLabel, bottomLabel])
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        topLabel
            .leadingAnchor(to: leadingAnchor, constant: 8)
            .topAnchor(to: topAnchor, constant: 8)
            .trailingAnchor(to: trailingAnchor, constant: 8)
            .heightAnchor(constant: 24)
            .activateAnchors()
        
        bottomLabel
            .leadingAnchor(to: leadingAnchor, constant: 8)
            .topAnchor(to: topLabel.bottomAnchor, constant: 8)
            .trailingAnchor(to: trailingAnchor, constant: 8)
            .heightAnchor(constant: 24)
            .activateAnchors()
    }

    func configureCell(viewModel: WeatherInfoViewModel?, item: Int) {
        self.topLabel.text = subInfoTitles[item]
        if let value = viewModel?.infos[item] {
            self.bottomLabel.text = value
        }
    }
}
