//
//  AppDelegate.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Propertiec
    
    var window: UIWindow?

    //MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = TabBarViewController()
        // Override point for customization after application launch.
        return true
    }
}

