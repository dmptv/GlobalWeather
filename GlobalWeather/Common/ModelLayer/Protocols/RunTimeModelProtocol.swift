//
//  RunTimeModelProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation

protocol RunTimeModelProtocol {
    static func storableType() -> StorableProtocol.Type
    func convertToStorable() -> StorableProtocol
}
