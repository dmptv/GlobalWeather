//
//  RootRouter.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

final class RootRouter: BaseCoordinatorRouter {
    private var window: UIWindow?
    
    init(scene: UIScene, _ rootViewController: UIViewController = UIViewController()) {
        super.init(rootViewController)
        
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene
        let vc = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.layoutIfNeeded()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
