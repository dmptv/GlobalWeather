//
//  MainPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Combine

class MainPresenter: BasePresenter
<MainModuleOutput,
MainInteractorInput,
MainRouterInputProtocol,
MainViewInput> {
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: Private
extension MainPresenter {
    
}

// MARK: Module Input
extension MainPresenter: MainModuleInput {
    
}

// MARK: View Output
extension MainPresenter: MainViewOutput {
    
}

// MARK: Interactor Output
extension MainPresenter: MainInteractorOutput {
    
}
