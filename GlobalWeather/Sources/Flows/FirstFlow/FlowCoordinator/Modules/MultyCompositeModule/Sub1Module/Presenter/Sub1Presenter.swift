//
//  Sub1Presenter.swift
//  GlobalWeather
//
//  Created by Kanat on 06.08.2023
//  
//

import Foundation

class Sub1Presenter: BasePresenter
<Sub1ModuleOutput,
Sub1InteractorInput,
Sub1RouterInputProtocol,
Sub1ViewInput> {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

// MARK: Private
extension Sub1Presenter {
    
}

// MARK: Module Input
extension Sub1Presenter: Sub1ModuleInput {
    
}

// MARK: View Output
extension Sub1Presenter: Sub1ViewOutput {
    
}

// MARK: Interactor Output
extension Sub1Presenter: Sub1InteractorOutput {
    
}
