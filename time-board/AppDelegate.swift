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
    
    private func loginCheck() {
        
        let driver = DatabaseDriver(setupType: .DatabaseQueue)
        driver.createTable(sql: SQLScriptCreateASAccout, complition: nil)
        driver.selectFromTable(of: ASAccount.self, complition: { [unowned self] result in
            switch result {
            case .success(let account):
                AppInfo.profile = account
                self.window?.rootViewController = AssemblerModuleBuilder().createTabBarModule()
                self.window?.makeKeyAndVisible()
            case.failure(_):
                let navContr = UINavigationController(rootViewController: AssemblerModuleBuilder().createLoginModule())
                self.window?.rootViewController = navContr
                self.window?.makeKeyAndVisible()
            }
        })
    }
    
    private func configureAppLaunch() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //MARK: Delete Test after all
//        let boardVC = BoardCollectionViewController.customInit(typeOfSteps: .Test)
        let boardVC = AssemblerModuleBuilder().createBoardModule(typeOfSteps: .Test)
        self.window?.rootViewController = AssemblerModuleBuilder().createTabBarModule()
//        self.window?.rootViewController = TestViewController()

        self.window?.makeKeyAndVisible()
        //        self.window?.backgroundColor = UIColor(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 0.9)
        self.window?.backgroundColor = .white
        
        
        //        loginCheck()
    }
    //MARK: - Orientation function
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
}

