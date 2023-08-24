//
//  InfoFeelingsPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import Foundation
import Combine

class InfoFeelingsPresenter: BasePresenter
<InfoFeelingsModuleOutput,
InfoFeelingsInteractorInput,
InfoFeelingsRouterInputProtocol,
InfoFeelingsViewInput> {
    private var cancellables = Set<AnyCancellable>()
    private(set) var feelingsPublisher = PassthroughSubject<WeatherInfoViewModel?, Never>()

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
extension InfoFeelingsPresenter {
    
}

// MARK: Module Input
extension InfoFeelingsPresenter: InfoFeelingsModuleInput {
    private func subscribeForModuleInput() {
        feelingsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vm in
                self?.view?.feelingsPublisher.send(vm)
            }
            .store(in: &cancellables)
    }
}

// MARK: View Output
extension InfoFeelingsPresenter: InfoFeelingsViewOutput {
    
}

// MARK: Interactor Output
extension InfoFeelingsPresenter: InfoFeelingsInteractorOutput {
    
}
