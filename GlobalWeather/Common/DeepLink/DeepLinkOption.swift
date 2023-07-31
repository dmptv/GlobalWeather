//
//  DeepLinkOption.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

enum DeepLinkOption: DeepLinkOptionProtocol {
    case initial
    
    public static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        return nil
    }
    
    public static func build(with dict: [String: AnyObject]?) -> DeepLinkOption? {
        guard let screen = dict?["screen"] as? String else {
            return nil
        }
        
        switch screen {
        default:
            return nil
        }
    }
}
