//
//  CommentAttachmentPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 21.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol ICommentAttachmentPresenter: class {
    func addCommentButtonTapped(comment: String)
    func cameraButtonTapped()
    func imageButtonTapped()
    func documentButtonTapped()
}
