//
//  Router.swift
//  time-board
//
//  Created by Tianid on 30.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IRouterMain {
    var tabBarController: ITabBarViewController? { get set }
    var assemblyBuilder: IAssembleBuilder? { get set }
    var loginController: UINavigationController? { get set }
}

protocol IRouter: IRouterMain {
    func showTaskDetailViewController(task: Task)
    func showDescriptionEditViewController(task: Task)
    func showImagePreview(attachments: [Attachment], startIndex: Int, images: [UIImage])
    func showRegistrationViewController()
    func dismissRegistrationViewController()
    func makeLogin()
    func makeLogout()
}

class Router: IRouter {

    //MARK: - Properties
    var tabBarController: ITabBarViewController?
    var assemblyBuilder: IAssembleBuilder?
    var loginController: UINavigationController?
    
    private var projectsNavigationController: UINavigationController?
    private var isshuesNavigationController: UINavigationController?
    private var notificationsNavigationsController: UINavigationController?
    private var profileNavigationsController: UINavigationController?
    
    //MARK: - Init
    init(view: UINavigationController, tabBar: ITabBarViewController, assembler: IAssembleBuilder) {
        self.tabBarController = tabBar
        self.assemblyBuilder = assembler
        self.loginController = view
    }
    
    //MARK: - FUnc
    func initiateTabBar() {
        guard let tabBar = tabBarController else { return }
        tabBar.configureTabBar(router: self)
        guard let controllers = tabBar.viewControllers as? [UINavigationController] else { return }
        
        for item in controllers {
            if item.viewControllers[0] is BoardCollectionViewController {
                self.projectsNavigationController = item
                continue
            }
            
            if item.viewControllers[0] is IsshuesViewController {
                self.isshuesNavigationController = item
                continue
            }
            
            if item.viewControllers[0] is NotificationsViewController {
                self.notificationsNavigationsController = item
                continue
            }
            
            if item.viewControllers[0] is ProfileViewController {
                self.profileNavigationsController = item
                continue
            }
        }
    }
    
    func initLoginViewController() {
        guard let loginNav = loginController else { return }
        guard let loginView = assemblyBuilder?.createLoginModule(router: self) else { return }
        loginNav.viewControllers = [loginView]
    }
    
    func showTaskDetailViewController(task: Task) {
        guard let projectsNav = projectsNavigationController else { return }
        guard let detailView = assemblyBuilder?.createDetailTaskModule(task: task, router: self) else { return }
        projectsNav.pushViewController(detailView, animated: true)
    }
    
    func showDescriptionEditViewController(task: Task) {
        guard let projectsNav = projectsNavigationController else { return }
        guard let descriptionView = assemblyBuilder?.createDescriptionEditModule(task: task, router: self) else { return }
        projectsNav.pushViewController(descriptionView, animated: true)
    }
    
    func showImagePreview(attachments: [Attachment], startIndex: Int, images: [UIImage]) {
        guard let projectsNav = projectsNavigationController else { return }
        guard let previewView = assemblyBuilder?.createPreviewAttachmentModule(attachments: attachments, startIndex: startIndex, images: images, router: self) else { return }
        projectsNav.pushViewController(previewView, animated: true)
    }
    
    func showRegistrationViewController() {
        guard let navContr = loginController else { return }
        guard let registrationController = assemblyBuilder?.createRegistrationModule(router: self) else { return }
        navContr.pushViewController(registrationController, animated: true)
    }
    
    func dismissRegistrationViewController() {
        guard let navContr = loginController else { return }
        navContr.popViewController(animated: true)
    }
    
    func makeLogin() {
        DispatchQueue.main.async {
            self.initiateTabBar()
            guard let app = UIApplication.shared.delegate?.window  else { return }
            app?.rootViewController = self.tabBarController
            self.animateChanging()
            self.deinitLoginViewController()
        }
    }
    
    func makeLogout() {
        DispatchQueue.main.async {
            self.initLoginViewController()
            guard let app = UIApplication.shared.delegate?.window  else { return }
            self.loginController?.popViewController(animated: false)
            app?.rootViewController = self.loginController
            self.animateChanging()
            self.deinitTabBar()
        }
    }
    
    private func deinitTabBar() {
        guard let tabBar = tabBarController else { return }
        tabBar.viewControllers?.removeAll()
        projectsNavigationController = nil
        isshuesNavigationController = nil
        notificationsNavigationsController = nil
        profileNavigationsController = nil
    }
    
    private func deinitLoginViewController() {
        guard let loginNav = loginController else { return }
        loginNav.viewControllers.removeAll()
    }
    
    private func animateChanging() {
        guard  let win = UIApplication.shared.keyWindow else { return }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: win, duration: duration, options: options, animations:nil, completion:nil)
    }
}
