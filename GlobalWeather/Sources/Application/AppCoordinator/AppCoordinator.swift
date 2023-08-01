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
    
    override func start(with option: DeepLinkOptionProtocol?) {
        startApp()
    }
}

extension AppCoordinator {
    private func startApp() {
        runFirstFlow()
    }
}

extension AppCoordinator {
    private func runFirstFlow() {
        childCoordinators.forEach { removeChild($0) }
        router.dismissModule()
        let firstCoordinator = FirstFlowCoordinatorAssembly().build(self)
        firstCoordinator.start()
        addChild(firstCoordinator)
        if let toPresent = firstCoordinator.toPresent() {
            router.showScreen(toPresent)
        }
    }
}

extension AppCoordinator: FirstFlowRoutingExitHandler {
    func performRouteForBackRouting(_ coordinator: CoordinatorProtocol) {
        
    }
    
    func performRouteForCloseRouting(_ coordinator: CoordinatorProtocol) {
        
    }
    
    func performModuleRemovedRouting(_ coordinator: CoordinatorProtocol) {
        
    }
    
    func performRouteForBackOrCloseRouting(_ coordinator: CoordinatorProtocol) {
        
    }
}



protocol AppCoordinatorExitPoint: ModuleRoutingHandlingProtocol { }

protocol AppCoordinatorProtocol: CoordinatorProtocol { }
