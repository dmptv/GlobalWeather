//
//  MultyViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import UIKit
import Combine

class MultyViewController: BaseViewController {
    var output: MultyViewOutput?
    private var cancellables = Set<AnyCancellable>()
    static let headerViewHeightRatio = CGFloat(0.38)
    
    @IBOutlet private weak var cityContainer: UIView!
    @IBOutlet private weak var hourContainer: UIView!
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
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: - Configure
extension MultyViewController: MultyViewInput {
    private func setupSubviews() {
        subscribeForPublishers()
    }
    
    private func subscribeForPublishers() {
        toolBar.weatherButtonDidTapSubject
            .sink { _ in
                
            }
            .store(in: &cancellables)
        
        toolBar.settingButtonDidTapSubject
            .sink { _ in
                
            }
            .store(in: &cancellables)
    }
}

// MARK: View Input
extension MultyViewController {
    
}

// MARK: Button Action
extension MultyViewController {
    
}

extension MultyViewController: MultyContainersHolderProtocol {
    var containerForCitySubmodule: UIView {
        cityContainer
    }
    
    var containerForHourSubmodule: UIView {
        hourContainer
    }
}
