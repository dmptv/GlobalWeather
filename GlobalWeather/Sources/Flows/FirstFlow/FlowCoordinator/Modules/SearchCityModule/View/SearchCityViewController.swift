//
//  SearchCityViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023
//  
//

import UIKit

class SearchCityViewController: BaseViewController {
    var output: SearchCityViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension SearchCityViewController: SearchCityViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension SearchCityViewController {
    
}

// MARK: Button Action
extension SearchCityViewController {
    
}
