//
//  ToolBar.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023.
//

import Then
import UIKit
import SnapKit
import Combine

class ToolBar: UIToolbar {
    private struct UI {
        static let basicMargin = CGFloat(16)
    }
    var weatherButtonDidTap = PassthroughSubject<Void, Never>()
    var settingButtonDidTap = PassthroughSubject<Void, Never>()
    
    private let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .default)
    private lazy var weatherButton = UIButton().then {
        $0.sizeToFit()
        $0.tintColor = .init(red: 0.29, green: 0.29, blue: 0.28, alpha: 1.00)
        $0.setImage(UIImage(systemName: "safari", withConfiguration: configuration), for: .normal)
        $0.addTarget(self, action: #selector(weatherButtondidTap(_:)), for: .touchUpInside)
    }
    
    private lazy var locationListButton = UIButton().then {
        $0.sizeToFit()
        $0.tintColor = .init(red: 0.29, green: 0.29, blue: 0.28, alpha: 1.00)
        $0.setImage(UIImage(systemName: "location.viewfinder", withConfiguration: configuration), for: .normal)
        $0.addTarget(self, action: #selector(locationButtondidTap(_:)), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}

extension ToolBar {
    private func setupViews() {
        barTintColor = .white
        addSubviews([weatherButton, locationListButton])
        setupConstraints()
    }
    
    private func setupConstraints() {
        weatherButton.snp
            .makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
                    .offset(UI.basicMargin)
        }
        
        locationListButton.snp
            .makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
                    .offset(-UI.basicMargin)
        }
    }
}

extension ToolBar {
    @objc private func weatherButtondidTap(_ sender: UIButton) {
        weatherButtonDidTap.send()
    }
    
    @objc private func locationButtondidTap(_ sender: UIButton) {
        settingButtonDidTap.send()
    }
}
