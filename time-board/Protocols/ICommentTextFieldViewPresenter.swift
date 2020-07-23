//
//  CommentAttachmentPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 21.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import Foundation
import UIKit

protocol ICommentTextFieldViewPresenter: class {
    var tempCommentAttachemnts: [Attachment] { get set }
    func addCommentButtonTapped(comment: String)
    func cameraButtonTapped()
    func imageButtonTapped()
    func documentButtonTapped()
    func addNewTextFieldCommentAttachment(data: Data, fileName: String, fileType: AttachmentFileType)
    func getImage(indexPath: IndexPath) -> UIImage?
    func textFieldAttachmentCellTapped(at index: IndexPath)
    func deleteTempAttachment(at index: IndexPath)
}
