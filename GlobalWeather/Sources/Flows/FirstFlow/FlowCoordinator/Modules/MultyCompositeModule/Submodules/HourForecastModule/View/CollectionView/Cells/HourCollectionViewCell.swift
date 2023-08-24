//
//  HourCollectionViewCell.swift
//  GlobalWeather
//
//  Created by Kanat on 22.08.2023.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        hourLabel.textColor = .white
        degreeLabel.textColor = .white
        
    }
}

extension HourCollectionViewCell {
    func configureCell(viewModel: WeatherViewModel) {
        hourLabel.text = viewModel.hour
        degreeLabel.text = viewModel.temp
        configure(iconName: viewModel.conditionImage)

    }
    
    func configure(iconName: String) {
        if let image = UIImage(systemName: iconName) {
            icon.image = image.withRenderingMode(.alwaysTemplate)
            icon.tintColor = .white
        }
    }
}
