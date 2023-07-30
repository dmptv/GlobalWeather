//
//  AppAppearance.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

final class AppAppearance {
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white,
                                                            .font: UIFont.systemFont(ofSize: 22)]
        
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                                                                                     for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                                                                                     for: .highlighted)
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().tintColor = .cyan
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        
        loaderViewColor = .gray
    }
        
    static func setUIBarButtonColor(color: UIColor) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color], for: .highlighted)
    }
    
    static func setUIBarButtonDefaultColor() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
    static func getNavigationTitle(textColor: UIColor?, title: String?) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.text = title
        return label
    }
    
    static func applyAppereanceForStatusBar(_ style: StatusBarStyle) -> UIStatusBarStyle {
            switch style {
            case .dark:
                if #available(iOS 13.0, *) {
                    return .darkContent
                }
                return .default
            case .light:
                return .lightContent
            }
        }

    enum StatusBarStyle {
        case dark
        case light
    }
}
