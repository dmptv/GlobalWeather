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
    @IBOutlet private weak var summaryContainer: UIView!
    @IBOutlet private weak var feelingsContainer: UIView!
    
    @IBOutlet private weak var toolBar: ToolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        output?.viewWillAppear()
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
        setupViewColor()
        setupToolbarColor()
    }
    
    private func setupViewColor() {
        let sunriseBackgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0).cgColor
        let sunsetBackgroundColor = UIColor(red: 0.8, green: 0.3, blue: 0.6, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [sunriseBackgroundColor, sunsetBackgroundColor]
        gradientLayer.frame = UIScreen.main.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupToolbarColor() {
        let sunriseColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
        let sunsetColor = UIColor(red: 0.8, green: 0.3, blue: 0.6, alpha: 1.0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [sunriseColor.cgColor, sunsetColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        toolBar.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func subscribeForPublishers() {
        toolBar.weatherButtonDidTapSubject
            .sink { _ in
                
            }
            .store(in: &cancellables)
        
        toolBar.settingButtonDidTapSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.output?.navigateToSeachSubject.send(())
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
    
    var containerForSummarySubmodule: UIView {
        summaryContainer
    }
    
    var containerForFeelingsSubmodule: UIView {
        feelingsContainer
    }
}
