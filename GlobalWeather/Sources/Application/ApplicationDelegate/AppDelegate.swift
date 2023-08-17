//
//  AppDelegate.swift
//  GlobalWeather
//
//  Created by Kanat on 27.07.2023.
//

import UIKit

/// https://github.com/devxoul/Then

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var app = AppServiceLocatorImpl().app()

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        app.application(application, willFinishLaunchingWithOptions: launchOptions)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.applicationDidFinishLaunching(application, launchOptions)
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        app.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        self.app.application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        app.application(application, shouldSaveApplicationState: coder)
    }
    
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        app.application(application, shouldRestoreApplicationState: coder)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        app.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        app.applicationWillEnterForeground(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        app.applicationWillResignActive(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        app.applicationDidBecomeActive(application)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

