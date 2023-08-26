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
    case mapError(message: String)
}

extension CustomAPIError: Equatable {
    static func == (lhs: CustomAPIError, rhs: CustomAPIError) -> Bool {
        switch (lhs, rhs) {
        case (.noLocalData, .noLocalData):
            return true
        case (.requestFailed, .requestFailed):
            return true
        case (.customError, .customError):
            return true
        default:
            return false
        }
    }
}
