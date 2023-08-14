//
//  AuthService.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol AuthServiceProtocol {
    func login(successHandler: BlockObject<AnyObject, Void>,
               errorHandler: ErrorBlock)
   
}

// MARK: - Implementation
class AuthService: AuthServiceProtocol {
    typealias ServiceLocatorAlias = NetworkingSessionServiceLocator
    final class ServiceLocator: ServiceLocatorAlias {
        init() {}
    }
    
    private let networkingManager: NetworkingSessionServiceProtocol

    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        networkingManager = serviceLocator.networkingSession()
        
    }
    
    func login(successHandler: BlockObject<AnyObject, Void>,
               errorHandler: ErrorBlock) { }
}
