//
//  CustomAPIError.swift
//  GlobalWeather
//
//  Created by Kanat on 16.08.2023.
//

import Alamofire

enum CustomAPIError: Error {
    case requestFailed(description: String)
    case customError(message: String)
    case noLocalData
}
