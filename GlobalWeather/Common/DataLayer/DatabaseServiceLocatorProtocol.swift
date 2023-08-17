//
//  DatabaseServiceLocatorProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023
//	
//

import Foundation

protocol DatabaseServiceLocatorProtocol {
    func serviceDatabase() -> DatabaseServiceProtocol
}

extension DatabaseServiceLocatorProtocol {
    func serviceDatabase() -> DatabaseServiceProtocol {
        return DatabaseService.shared
    }
}
