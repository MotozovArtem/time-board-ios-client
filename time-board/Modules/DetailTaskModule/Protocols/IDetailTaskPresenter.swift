//
//  DetailTaskPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

enum StorageSource {
    case temp, attachments, comments
}

protocol IDetailTaskPresenterMain: class {
    var task: Task { get set }
    var cache: NSCache<AnyObject, AnyObject> { get set }
    var tempCommentAttachemnts: [Attachment] { get set }
}

protocol IDetailTaskPresenter: IDetailTaskPresenterMain {

    func addAttachmentTapped()
    func attachmentCellLongTapped(indexPath: IndexPath)
    func attachmentCellTapped(startIndex: Int)
    func addNewAttachment(data: Data, fileName: String, fileType: AttachmentFileType)
    func deleteAttachmentTapped(indexPath: IndexPath)
    func getImage(indexPath: IndexPath, storage: StorageSource) -> UIImage?
    func getAllImages() -> [UIImage]
    func descriptionLabelTapped() 
}

protocol ICommentTextFieldViewPresenter: IDetailTaskPresenterMain {
    func addCommentButtonTapped(comment: String)
    func cameraButtonTapped()
    func imageButtonTapped()
    func documentButtonTapped()
    func addNewTextFieldCommentAttachment(data: Data, fileName: String, fileType: AttachmentFileType)
    func getImage(indexPath: IndexPath, storage: StorageSource) -> UIImage?
    func textFieldAttachmentCellLongTapped(at index: IndexPath)
    func textFieldAttachmentCellSingleTapped(at index: IndexPath)
    func deleteTempAttachment(at index: IndexPath)
}

protocol ICommentViewPresenter: IDetailTaskPresenterMain {
    func getImage(indexPath: IndexPath, storage: StorageSource) -> UIImage?
    func getImageFromComment(commentIndex: Int, index: Int) -> UIImage?
    func getAllImages(for index: Int) -> [UIImage]
    func showPreview(commentIndex: Int, startIndex: Int)
}
