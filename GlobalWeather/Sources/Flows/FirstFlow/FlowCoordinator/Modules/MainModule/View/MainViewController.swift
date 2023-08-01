//
//  MainViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import UIKit

class MainViewController: BaseViewController {
    var output: MainViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension MainViewController: MainViewInput {
    private func setupSubviews() {
        view.backgroundColor = .cyan
    }
}

// MARK: View Input
extension MainViewController {
    
}

// MARK: Button Action
extension MainViewController {
    
}
