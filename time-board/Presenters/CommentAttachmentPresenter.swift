//
//  CommentAttachmentPresenter.swift
//  time-board
//
//  Created by Tianid on 21.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class CommentAttachmentPresenter: CommentAttachmentPresenterProtocol {

    //MARK: - Properties
    private weak var parent: CommentTextFieldDetailViewControllerProtocol?
    
    //MARK: - Init
    init(parent: CommentTextFieldDetailViewControllerProtocol) {
        self.parent = parent
    }
    
    //MARK: - Func
    
    func addCommentButtonTapped(comment: String) {
        parent?.addNewComment(comment: comment)
    }
    
    func cameraButtonTapped() {
        parent?.showCameraController()
    }
    
    func imageButtonTapped() {
        parent?.showImagePicker()
    }
    
    func documentButtonTapped() {
        parent?.showDocumentPickerController()
    }
}
