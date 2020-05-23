//
//  AppDelegate.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Propertiec
    
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all
    //MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureLog()
        configureAppLaunch()
        
        // Override point for customization after application launch.
        return true
    }
    
    private func configureLog() {
        DDLog.add(DDOSLogger.sharedInstance)
        DDOSLogger.sharedInstance.logFormatter = CustomLogFormatter()
    }
    
    private func isLoggined() -> Bool {
        guard let _ = TBSettings.shared.getUser() else { return false }
        return true
    }
    
    private func configureAppLaunch() {
        if isLoggined() {
            window?.rootViewController = TabBarViewController()
        } else {
            let navContr = UINavigationController(rootViewController: LoginViewController())
            window?.rootViewController = navContr
        }
    }
    //MARK: - Orientation function
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
}

