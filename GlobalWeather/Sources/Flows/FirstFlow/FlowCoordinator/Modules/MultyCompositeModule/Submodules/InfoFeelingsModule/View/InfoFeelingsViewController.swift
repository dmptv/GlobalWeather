//
//  InfoFeelingsViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import UIKit
import Combine

class InfoFeelingsViewController: BaseViewController {
    var output: InfoFeelingsViewOutput?
    private var cancellables = Set<AnyCancellable>()
    private(set) var feelingsPublisher = PassthroughSubject<WeatherInfoViewModel?, Never>()
    private let subInfoTitles = ["Feels like", "Humidity", "Pressure", "Wind Speed", "Wind Direction", "Visibility"]

    @IBOutlet weak var feelingsCollectionView: FeelingsCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
        
        subscribeForViewInput()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: - Configure
extension InfoFeelingsViewController: InfoFeelingsViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension InfoFeelingsViewController {
    private func subscribeForViewInput() {
        feelingsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vm in
                self?.configure(vm)
            }
            .store(in: &cancellables)
    }
    
    private func configure(_ viewModel: WeatherInfoViewModel?) {
        feelingsCollectionView.viewModel = viewModel
        feelingsCollectionView.reloadData()
    }
}

// MARK: Button Action
extension InfoFeelingsViewController {
    
}
