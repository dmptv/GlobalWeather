//
//  UserService.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol UserServiceProtocol {
    func setData<T>(_ data: T?)
    func setData<T>(_ data: T?, fireUpdate: Bool)
    func getData<T>() -> T?
    
    func removeAll()
        
    func addListener<T>(_ listener: BlockObject<T?, Void>)
    func removeListener(_ uuid: UUID)
}

extension UserServiceProtocol {
    func setData<T>(_ data: T?) {
        setData(data, fireUpdate: true)
    }
}

class UserService: UserServiceProtocol {
    private static let userKey = "userKey"
    
    static let shared = UserService()
    
    typealias ServiceLocatorAlias = UserDefaultsServiceLocator
    final class ServiceLocator: ServiceLocatorAlias {}
    
    private let syncQueue = DispatchQueue(label: "com.UserService.syncQueue")
    
    //TODO: Move to model
    private var listeners: [String: [UUID: Any]] = [:]
    private var storedData: [String: Any] = [:]
    
    private let userDefaultsService: UserDefaultsProtocol
    
    private init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        userDefaultsService = serviceLocator.userDefaults()
    }
    
    func setData<T>(_ data: T?, fireUpdate: Bool) {
        let key = String(describing: T.self)
        storedData[key] = data
        
        if fireUpdate {
            executeListeners(data)
        }
    }
    
    func getData<T>() -> T? {
        let key = String(describing: T.self)
        return storedData[key] as? T
    }
    
    func addListener<T>(_ listener: BlockObject<T?, Void>) {
        syncQueue.sync {
            let type = String(describing: T.self)
            if listeners[type] == nil {
                listeners[type] = [:]
            }
            listeners[type]?[listener.identifier] = listener
        }
    }
    
    func removeListener(_ uuid: UUID) {
        syncQueue.sync {
            listeners.forEach { type in
                listeners[type.key]?[uuid] = nil
            }
        }
    }
    
    func removeAll() {
        syncQueue.sync {
            storedData.removeAll()
            listeners.removeAll()
        }
    }
    
    private func executeListeners<T>(_ object: T?) {
        syncQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            self.listeners[String(describing: T.self)]?.forEach {
                ($0.1 as? BlockObject<T?, Void>)?.execute(object)
            }
        }
    }
}
