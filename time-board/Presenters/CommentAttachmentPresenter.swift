//
//  CommentAttachmentPresenter.swift
//  time-board
//
//  Created by Tianid on 21.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

class CommentAttachmentPresenter: ICommentAttachmentPresenter {

    //MARK: - Properties
    private weak var parent: ICommentTextFieldDetailViewController?
    var tempCommentAttachemnts: [Attachment] = []
    var cache: NSCache<AnyObject, AnyObject>
    
    //MARK: - Init
    init(parent: ICommentTextFieldDetailViewController) {
        self.parent = parent
        self.cache = NSCache()
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
    
    func addNewTextFieldCommentAttachment(data: Data, fileName: String, fileType: AttachmentFileType) {
        let attachment = Attachment(attachmentURL: fileName)
        attachment.file = File(data: data, fileType: fileType)
        tempCommentAttachemnts.append(attachment)

        switch fileType {
        case .jpeg, .jpg, .gif, .png, .heic:
            let uiImage = UIImage(data: data)
            cache.setObject(uiImage!, forKey: fileName as NSString)
        case .notImage:
            let _ = getFileImage()
        }
        
        let indexPath = IndexPath(item: tempCommentAttachemnts.count - 1, section: 0)
        parent?.addTextFieldCommentAttachmentDataAt(indexPath: indexPath)
    }
    
    func getImage(indexPath: IndexPath) -> UIImage? {
        guard let fileType = tempCommentAttachemnts[indexPath.row].file?.fileType else  { return nil }
        if fileType == .notImage{
            let image = getFileImage()
            return image
        } else {
            if let image = getImageFromCache(attachmentURL: tempCommentAttachemnts[indexPath.row].attachmentURL) {
                return image
            }
            if let image = getImageFromData(indexPath: indexPath) {
                return image
            }
        }
        return nil
    }
    
    func textFieldAttachmentCellTapped(at index: IndexPath) {
        parent?.showTextFieldAttachmentCellAlert(at: index)
    }
    
    func deleteTempAttachment(at index: IndexPath) {
        tempCommentAttachemnts.remove(at: index.row)
        cache.removeObject(forKey: tempCommentAttachemnts[index.row].attachmentURL as NSString)
    }
    
    func resetTempAttachment() {
        tempCommentAttachemnts.removeAll()
    }
    
    private func getImageFromCache(attachmentURL: String) -> UIImage? {
        guard let imageFromCache = cache.object(forKey: attachmentURL as NSString) as? UIImage else {
            return nil
        }
        return imageFromCache
    }
    
    private func getFileImage() -> UIImage? {
        if let image = getImageFromCache(attachmentURL: "icons8-file-50.png") {
            return image
        }
        guard let image = UIImage(named: "icons8-file-50.png") else { return nil }
        cache.setObject(image, forKey: "icons8-file-50.png" as NSString)
        return image
        
    }
    
    private func getImageFromData(indexPath: IndexPath) -> UIImage? {
        guard let data = tempCommentAttachemnts[indexPath.row].file?.fileData else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        let attachmentURL = tempCommentAttachemnts[indexPath.row].attachmentURL
        cache.setObject(image, forKey: attachmentURL as NSString)
        return image
    }
}
