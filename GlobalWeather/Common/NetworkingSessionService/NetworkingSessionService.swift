//
//  NetworkingSessionService.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation
protocol NetworkingSessionServiceProtocol { }

class NetworkingSessionService: NetworkingSessionServiceProtocol {
    static let shared = NetworkingSessionService()
    
    init() { }
}
