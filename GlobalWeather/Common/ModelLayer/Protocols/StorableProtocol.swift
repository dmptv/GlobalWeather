//
//  StorableProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Foundation
import RealmSwift

protocol StorableProtocol: Object {
    func createRuntimeModel() -> RunTimeModelProtocol
}
