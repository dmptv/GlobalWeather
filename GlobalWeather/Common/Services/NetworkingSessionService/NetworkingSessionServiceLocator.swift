//
//  NetworkingSessionServiceLocator.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol NetworkingSessionServiceLocator {
    func networkingSession() -> NetworkingSessionServiceProtocol
}

extension NetworkingSessionServiceLocator {
    func networkingSession() -> NetworkingSessionServiceProtocol {
        NetworkingSessionService.shared
    }
}
