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
        
    }
}

extension HourCollectionViewCell {
    func configureCell(viewModel: WeatherViewModel) {
        hourLabel.text = viewModel.hour
        icon.image = UIImage(named: viewModel.conditionImage)
        degreeLabel.text = viewModel.temp
    }
}
