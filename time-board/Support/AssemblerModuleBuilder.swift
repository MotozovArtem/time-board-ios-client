//
//  AssembleModelBuilder.swift
//  time-board
//
//  Created by Tianid on 28.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol AssembleBuilderProtocol {
    func createBoardModule(typeOfSteps: BoardVCType) -> UIViewController
    func createDetailTaskModule(task: Task) -> UIViewController
}

class AssemblerModuleBuilder: AssembleBuilderProtocol {

    
    func createBoardModule(typeOfSteps: BoardVCType) -> UIViewController {
        let view = UIStoryboard(name: "Board", bundle: nil).instantiateViewController(withIdentifier: "BoardVC") as! BoardCollectionViewController
        let presenter = BoardCollectionPresenter(superView: view, boardType: typeOfSteps)
        view.presenter = presenter
        return view
    }
    
    func createDetailTaskModule(task: Task) -> UIViewController {
        let view = DetailTaskViewController()
        let presenter = DetailTaskPresenter(controller: view, task: task)
        view.presenter = presenter
        return view
    }
    
    func createPreviewAttachmentModule(attachments: [Attachment], startIndex: Int, images: [UIImage]) -> UIViewController {
        let view = PreviewAttachmentViewController(images: images, startImage: startIndex)
        let presenter = PreviewPresenter(attachments: attachments, parent: view)
        view.presenter = presenter
        return view
    }
    
    func createDescriptionEditModule(task: Task) -> UIViewController {
        let view = DescriptionEditViewController()
        let presenter = DescriptionEditPresenter(view: view, task: task)
        view.presenter = presenter
        return view
    }
    
    func createProfileViewModule() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule() -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createProjetsModule() -> UIViewController {
        let view = ProjectsViewController()
        let presenter = ProjectsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createIsshuesModule() -> UIViewController {
        let view = IsshuesViewController()
        let presenter = IsshuesPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createNotificationsModule() -> UIViewController {
        let view = NotificationsViewController()
        let presenter = NotificationsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createTabBarModule() -> UIViewController {
        let view = TabBarViewController()
        let presenter = TabBarPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    
}
