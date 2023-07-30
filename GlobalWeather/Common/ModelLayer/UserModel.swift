//
//  UserModel.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

struct UserModel: Codable {
    var firstName: String?
    
    init(firstName: String) {
        self.firstName = firstName
    }
}
