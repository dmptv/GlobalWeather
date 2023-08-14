//
//  ResponseProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 14.08.2023.
//

import Foundation

protocol ResponseProtocol {
    static func responseObject(_ data: Data?,
                               _ response: HTTPURLResponse) throws -> Self
}
