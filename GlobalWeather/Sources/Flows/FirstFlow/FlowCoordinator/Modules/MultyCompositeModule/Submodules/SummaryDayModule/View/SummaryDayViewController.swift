//
//  SummaryDayViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import UIKit
import Combine

class SummaryDayViewController: BaseViewController {
    var output: SummaryDayViewOutput?
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var summaryDayPublisher = PassthroughSubject<WeatherDailyViewModel, Never>()

    @IBOutlet private weak var descriptionLabel: TopAlignedLabel!
    
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
extension SummaryDayViewController: SummaryDayViewInput {
    private func setupSubviews() {
        descriptionLabel.textColor = UIColor(red: 0.9, green: 0.75, blue: 0.85, alpha: 1.0)
    }
}

// MARK: View Input
extension SummaryDayViewController {
    private func subscribeForViewInput() {
        summaryDayPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vm in
                self?.configure(vm)
            }
            .store(in: &cancellables)
    }
    
    private func configure(_ viewModel: WeatherDailyViewModel) {
        descriptionLabel.text = "Expect mostly \(weatherCondition(from: viewModel.conditionImage[0])) conditions. The projected high temperature \(viewModel.temp_max[0])"
    }
    
    private func weatherCondition(from imageName: String) -> String {
        switch imageName {
        case "cloud.bolt.rain.fill":
            return "thunderstorms"
        case "cloud.drizzle.fill":
            return "drizzling"
        case "cloud.rain.fill":
            return "raining"
        case "snow":
            return "snowing"
        case "wind":
            return "windy"
        case "sun.max":
            return "clear"
        default:
            return "cloudy"
        }
    }
}

// MARK: Button Action
extension SummaryDayViewController {
    
}


