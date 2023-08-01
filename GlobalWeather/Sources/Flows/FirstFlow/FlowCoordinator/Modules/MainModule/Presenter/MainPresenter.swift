//
//  MainPresenter.swift
//  GlobalWeather
//
//  Created by Kanat on 01.08.2023
//  
//

import Foundation

class MainPresenter: BasePresenter
<MainModuleOutput,
MainInteractorInput,
MainRouterInputProtocol,
MainViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()        
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
