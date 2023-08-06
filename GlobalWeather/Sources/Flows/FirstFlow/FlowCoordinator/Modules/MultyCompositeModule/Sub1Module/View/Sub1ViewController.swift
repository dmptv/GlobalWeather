//
//  Sub1ViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit

class Sub1ViewController: BaseViewController {
    var output: Sub1ViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension Sub1ViewController: Sub1ViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension Sub1ViewController {
    
}

// MARK: Button Action
extension Sub1ViewController {
    
}
