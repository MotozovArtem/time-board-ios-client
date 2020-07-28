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
    
    
    
}
