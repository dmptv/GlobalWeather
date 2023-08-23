//
//  SummaryDayPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import Foundation
import Combine

class SummaryDayPresenter: BasePresenter
<SummaryDayModuleOutput,
SummaryDayInteractorInput,
SummaryDayRouterInputProtocol,
SummaryDayViewInput> {
    private var cancellables = Set<AnyCancellable>()
    private(set) var summaryDayPublisher = PassthroughSubject<WeatherDailyViewModel, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeForModuleInput()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension SummaryDayPresenter {
    
}

// MARK: Module Input
extension SummaryDayPresenter: SummaryDayModuleInput {
    private func subscribeForModuleInput() {
        summaryDayPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vm in
                self?.view?.summaryDayPublisher.send(vm)
            }
            .store(in: &cancellables)
    }
}

// MARK: View Output
extension SummaryDayPresenter: SummaryDayViewOutput {
    
}

// MARK: Interactor Output
extension SummaryDayPresenter: SummaryDayInteractorOutput {
    
}
