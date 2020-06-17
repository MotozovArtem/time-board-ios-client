//
//  TabBarViewController.swift
//  time-board
//
//  Created by Tianid on 01.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureTabBar() {
//        let projectsController = ProjectsViewController()
        let projectsController = BoardCollectionViewController.customInit(typeOfSteps: .Test)
        let isshuesController = IsshuesViewController()
        let notificationsController = NotificationsViewController()
        let profileController = ProfileViewController()
        
        let projectsItem = UITabBarItem(title: "Projects", image: #imageLiteral(resourceName: "icons8-tab-50"), selectedImage:  #imageLiteral(resourceName: "icons8-tab-50-2"))
        let isshuesItem = UITabBarItem(title: "Isshues", image: #imageLiteral(resourceName: "icons8-broken-bottle-50"), selectedImage:  #imageLiteral(resourceName: "icons8-broken-bottle-50-2"))
        let notificatinsItem = UITabBarItem(title: "Notifications", image: #imageLiteral(resourceName: "icons8-tag-window-50"), selectedImage:  #imageLiteral(resourceName: "icons8-tag-window-50-2"))
        let profileItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "icons8-top-menu-50"), selectedImage:  #imageLiteral(resourceName: "icons8-top-menu-50-2"))
        
        projectsController.tabBarItem = projectsItem
        isshuesController.tabBarItem = isshuesItem
        notificationsController.tabBarItem = notificatinsItem
        profileController.tabBarItem = profileItem
        
        let projectsNavigationController = UINavigationController(rootViewController: projectsController)
        let isshuesNavigationController = UINavigationController(rootViewController: isshuesController)
        let notificationsNavigationsController = UINavigationController(rootViewController: notificationsController)
        let profileNavigationsController = UINavigationController(rootViewController: profileController)
        
        let controllers = [projectsNavigationController, isshuesNavigationController, notificationsNavigationsController, profileNavigationsController]
        self.viewControllers = controllers
    }
}
