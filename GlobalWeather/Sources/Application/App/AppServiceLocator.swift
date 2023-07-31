//
//  AppServiceLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 31.07.2023.
//

protocol AppServiceLocator {
    func app() -> AppProtocol
}

extension AppServiceLocator {
    func app() -> AppProtocol {
        App()
    }
}

final class AppServiceLocatorImpl: AppServiceLocator {}
