//
//  MultyViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit

class MultyViewController: BaseViewController {
    var output: MultyViewOutput?
    
    @IBOutlet var container1: UIView!
    @IBOutlet var container2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension MultyViewController: MultyViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension MultyViewController {
    
}

// MARK: Button Action
extension MultyViewController {
    
}

extension MultyViewController: MultyContainersHolderProtocol {
    var containerForSubmodule1: UIView {
        container1
    }
    
    var containerForSubmodule2: UIView {
        container2
    }
}