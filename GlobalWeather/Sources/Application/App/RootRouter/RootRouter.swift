//
//  RootRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

final class RootRouter: BaseCoordinatorRouter {
    private var window: UIWindow?
    
    override init(_ rootViewController: UIViewController = UIViewController()) {
        super.init(rootViewController)
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
