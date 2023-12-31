//
//  UserDefaultsService.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol UserDefaultsProtocol {
    func set<V: Codable>(_ value: V?, _ key: String)
    func getValue<V: Codable>(forKey defaultName: String) -> V?
    func removeObject(forKey aKey: String)
}

extension UserDefaults: UserDefaultsProtocol {
    func set<V>(_ value: V?, _ key: String) where V : Codable {
        guard let value = value else {
            removeObject(forKey: key)
            return
        }
        let data = try? JSONEncoder().encode(value)
        setValue(data, forKey: key)
    }
    
    func getValue<V>(forKey defaultName: String) -> V? where V : Codable {
        guard let valueData = data(forKey: defaultName) else {
            return nil
        }

        let value = try? JSONDecoder().decode(V.self, from: valueData)
        return value
    }
}

protocol UserDefaultsServiceLocator {
    func userDefaults() -> UserDefaultsProtocol
}

extension UserDefaultsServiceLocator {
    func userDefaults() -> UserDefaultsProtocol {
        UserDefaults.standard
    }
}
