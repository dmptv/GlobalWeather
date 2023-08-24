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
        
        hourLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        degreeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
    }
}

extension HourCollectionViewCell {
    func configureCell(viewModel: WeatherViewModel) {
        hourLabel.text = viewModel.hour
        degreeLabel.text = viewModel.temp
        configure(iconName: viewModel.conditionImage)
    }
    
    private func configure(iconName: String) {
        if let image = UIImage(systemName: iconName) {
            icon.image = image.withRenderingMode(.alwaysTemplate)
            icon.tintColor = .white
        }
    }
}
