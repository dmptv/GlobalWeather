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
    private(set) var summaryDayPublisher = PassthroughSubject<[WeatherDailyViewModel], Never>()

    
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
        
    }
}

// MARK: View Input
extension SummaryDayViewController {
    private func subscribeForViewInput() {
        summaryDayPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vms in
                
            }
            .store(in: &cancellables)
    }
}

// MARK: Button Action
extension SummaryDayViewController {
    
}
