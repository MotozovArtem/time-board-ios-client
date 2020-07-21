//
//  CommentAttachmentPresenter.swift
//  time-board
//
//  Created by Tianid on 21.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class CommentAttachmentPresenter: ICommentAttachmentPresenter {

    //MARK: - Properties
    private weak var parent: ICommentTextFieldDetailViewController?
    
    //MARK: - Init
    init(parent: ICommentTextFieldDetailViewController) {
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
