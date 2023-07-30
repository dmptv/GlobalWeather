//
//  AppInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol AppInteractorInputProtocol {
    func start(_ completion: EmptyBlock)
    func performLogout()
    func loginWith(firtsName: String, progressBlock: BlockObject<AnyObject, Void>)
}

class AppInteractor: AppInteractorInputProtocol {
    typealias ServiceLocatorAlias = UserServiceLocatorProtocol &
    UserDefaultsServiceLocator
    
    final class ServiceLocator: ServiceLocatorAlias {}
    
    private var userService: UserServiceProtocol
    private let userDefaults: UserDefaultsProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        userService = serviceLocator.userService()
        userDefaults = serviceLocator.userDefaults()
    }
    
    func start(_ completion: EmptyBlock) {
    }
    
    
    func performLogout() {
        userService.removeAll()
        removeUserDefaultsObjects()
        deleteCookies()
    }
    
    func deleteCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        cookieStorage.cookies?.forEach {
            cookieStorage.deleteCookie($0)
        }
    }
    
    func removeUserDefaultsObjects() {
        userDefaults.removeObject(forKey: "")
    }
    
    func loginWith(firtsName: String, progressBlock: BlockObject<AnyObject, Void>) {
        
    }
    
}
