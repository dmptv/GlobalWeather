//
//  APIClientServiceLocatorProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 02.08.2023
//	
//

import Foundation

protocol APIClientServiceLocator {
    func serviceAPIClient() -> APIClientServiceProtocol
}

extension APIClientServiceLocator {
    func serviceAPIClient() -> APIClientServiceProtocol {
        return APIClientService()
    }
}
