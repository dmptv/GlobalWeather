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
    static let headerViewHeightRatio = CGFloat(0.38)
    
    @IBOutlet private weak var container1: UIView!
    @IBOutlet private weak var container2: UIView!
    @IBOutlet private weak var toolBar: ToolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
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
