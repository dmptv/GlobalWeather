//
//  AppCoordinator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

final class AppCoordinator: BaseCoordinator<AppCoordinatorExitPoint>, AppCoordinatorProtocol {
    typealias ServiceLocator = RootRouterLocator &
    UserServiceLocatorProtocol &
    UserDefaultsServiceLocator &
    APIServicesLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private var userService: UserServiceProtocol
    private let userDefaults: UserDefaultsProtocol
    private let authService: AuthServiceProtocol
    private let interactor: AppInteractorInputProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        userService = serviceLocator.userService()
        userDefaults = serviceLocator.userDefaults()
        authService =  serviceLocator.authService()
        interactor = AppInteractor()
        let router = serviceLocator.rootRouter()
        super.init(router: router)
    }
    
}

protocol AppCoordinatorExitPoint: ModuleRoutingHandlingProtocol { }

protocol AppCoordinatorProtocol: CoordinatorProtocol { }
