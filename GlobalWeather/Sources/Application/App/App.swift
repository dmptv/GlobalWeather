//
//  AppProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

protocol AppProtocol {
    func configureScene(with scene: UIScene)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationDidFinishLaunching(_ application: UIApplication,
                                       _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool
    func application(_ application: UIApplication,
                     shouldSaveApplicationState coder: NSCoder) -> Bool
    func application(_ application: UIApplication,
                     shouldRestoreApplicationState coder: NSCoder) -> Bool
    
    func applicationDidEnterBackground(_ application: UIApplication)
    func applicationWillEnterForeground(_ application: UIApplication)
    func applicationWillResignActive(_ application: UIApplication)
    func applicationDidBecomeActive(_ application: UIApplication)
}

final class App: NSObject, AppProtocol {
    typealias ServiceLocator = AppCoordinatorServiceLocator & UserDefaultsServiceLocator
    final class ServiceLocatorImpl: ServiceLocator { }
    
    let serviceLocator: ServiceLocator = ServiceLocatorImpl()
    private var appCoordinator: CoordinatorProtocol?
    private let userDefaults: UserDefaultsProtocol
    private var privacyProtectionWindow: UIWindow?
    
    static let shared = App()
    
    private override init() {
        userDefaults = serviceLocator.userDefaults()
    }
    
    func configureScene(with scene: UIScene) {
        appCoordinator = serviceLocator.appCoordinator(scene: scene)
    }
    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        appCoordinator?.start()
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppAppearance.setupAppearance()
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: notification)
        appCoordinator?.start(with: deepLink)
        return true
    }
    
   
    func applicationDidReceiveRemoteNotification(_ application: UIApplication,
                                                 _ userInfo: [AnyHashable: Any],
                                                 _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let dict = userInfo as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: dict)
        appCoordinator?.start(with: deepLink)
        completionHandler(.noData)
    }
    
    func applicationContinueUserActivity(_ application: UIApplication,
                                         _ userActivity: NSUserActivity,
                                         _ restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let deepLink = DeepLinkOption.build(with: userActivity)
        appCoordinator?.start(with: deepLink)
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication,
                     shouldSaveApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    func application(_ application: UIApplication,
                     shouldRestoreApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        showPrivacyProtectionWindow()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        hidePrivacyProtectionWindow()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        showPrivacyProtectionWindow()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        hidePrivacyProtectionWindow()
    }
}


private extension App {
    func showPrivacyProtectionWindow() {
        privacyProtectionWindow = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        privacyProtectionWindow?.rootViewController = vc
        privacyProtectionWindow?.windowLevel = .alert + 1
        privacyProtectionWindow?.makeKeyAndVisible()
    }
    
    func hidePrivacyProtectionWindow() {
        privacyProtectionWindow?.isHidden = true
        privacyProtectionWindow = nil
    }
}
