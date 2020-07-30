//
//  AssembleModelBuilder.swift
//  time-board
//
//  Created by Tianid on 28.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IAssembleBuilder {
    func createBoardModule(typeOfSteps: BoardVCType, router: IRouter) -> UIViewController
    func createDetailTaskModule(task: Task, router: IRouter) -> UIViewController
    func createPreviewAttachmentModule(attachments: [Attachment], startIndex: Int, images: [UIImage], router: IRouter) -> UIViewController
    func createDescriptionEditModule(task: Task, router: IRouter) -> UIViewController
    func createProfileViewModule(router: IRouter) -> UIViewController
    func createLoginModule(router: IRouter) -> UIViewController
    func createRegistrationModule(router: IRouter) -> UIViewController
    func createProjetsModule(router: IRouter) -> UIViewController
    func createIsshuesModule(router: IRouter) -> UIViewController
    func createNotificationsModule(router: IRouter) -> UIViewController
    func createTabBarModule(router: IRouter) -> UITabBarController
}

class AssemblerModuleBuilder: IAssembleBuilder {

    
    func createBoardModule(typeOfSteps: BoardVCType, router: IRouter) -> UIViewController {
        let view = UIStoryboard(name: "Board", bundle: nil).instantiateViewController(withIdentifier: "BoardVC") as! BoardCollectionViewController
        let presenter = BoardCollectionPresenter(superView: view, boardType: typeOfSteps, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailTaskModule(task: Task, router: IRouter) -> UIViewController {
        let view = DetailTaskViewController()
        let presenter = DetailTaskPresenter(controller: view, task: task, router: router)
        view.presenter = presenter
        return view
    }
    
    func createPreviewAttachmentModule(attachments: [Attachment], startIndex: Int, images: [UIImage], router: IRouter) -> UIViewController {
        let view = PreviewAttachmentViewController(images: images, startImage: startIndex)
        let presenter = PreviewPresenter(attachments: attachments, parent: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDescriptionEditModule(task: Task, router: IRouter) -> UIViewController {
        let view = DescriptionEditViewController()
        let presenter = DescriptionEditPresenter(view: view, task: task, router: router)
        view.presenter = presenter
        return view
    }
    
    func createProfileViewModule(router: IRouter) -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createLoginModule(router: IRouter) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: IRouter) -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createProjetsModule(router: IRouter) -> UIViewController {
        let view = ProjectsViewController()
        let presenter = ProjectsPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createIsshuesModule(router: IRouter) -> UIViewController {
        let view = IsshuesViewController()
        let presenter = IsshuesPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createNotificationsModule(router: IRouter) -> UIViewController {
        let view = NotificationsViewController()
        let presenter = NotificationsPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createTabBarModule(router: IRouter) -> UITabBarController {
        let view = TabBarViewController()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
}
