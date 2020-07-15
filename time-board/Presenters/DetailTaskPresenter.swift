//
//  DetailTaskPresenter.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class DetailTaskPresenter {
    var task: Task
    var cache: NSCache<AnyObject, AnyObject>
    
    private weak var parrent: DetailTaskViewControllerProtocol?
    
    init(controller: DetailTaskViewControllerProtocol, task: Task) {
        self.parrent = controller
        self.task = task
        self.cache = NSCache()
    }
    
    private func getImageFromCache(attachmentURL: String) -> UIImage? {
        guard let imageFromCache = cache.object(forKey: attachmentURL as NSString) as? UIImage else { return nil }
        return imageFromCache
    }
    
    private func getImageFromData(indexPath: IndexPath) -> UIImage? {
        guard let data = task.attachments[indexPath.row].file?.fileData else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        let attachmentURL = task.attachments[indexPath.row].attachmentURL
        cache.setObject(image, forKey: attachmentURL as NSString)
        return image
    }
    
    private func getFileImage() -> UIImage? {
        if let image = getImageFromCache(attachmentURL: "icons8-file-50.png") {
            return image
        }
        guard let image = UIImage(named: "icons8-file-50.png") else { return nil }
        cache.setObject(image, forKey: "icons8-file-50.png" as NSString)
        return image
        
    }
}

extension DetailTaskPresenter: DetailTaskPresenterProtocol {
    
    func addAttachmentTapped() {
        parrent?.showAddNewAttachmentAlert()
    }
    
    func attachmentCellLongTapped(indexPath: IndexPath) {
        parrent?.showAttachmentCellAlert(indexPath: indexPath)
    }
    
    func attachmentCellTapped(viewController: UIViewController) {
        parrent?.showImagePreview(viewController: viewController)
    }
    
    func addNewAttachment(data: Data, fileName: String, fileType: AttachmentFileType) {
        let attachment = Attachment(attachmentURL: fileName)
        attachment.file = File(data: data, fileType: fileType)
        task.attachments.append(attachment)

        switch fileType {
        case .jpeg, .jpg, .gif, .png, .heic:
            let uiImage = UIImage(data: data)
            cache.setObject(uiImage!, forKey: fileName as NSString)
        case .notImage:
            break
        }
        
        let indexPath = IndexPath(item: task.attachments.count - 1, section: 1)
        parrent?.addAttachmentDataAt(indexPath: indexPath)
    }
    
    func deleteAttachmentTapped(indexPath: IndexPath) {
        let attachmentURL = task.attachments[indexPath.row].attachmentURL
        cache.removeObject(forKey: attachmentURL as NSString)
        task.attachments.remove(at: indexPath.row)
        parrent?.deleteAttachmentDataAt(indexPath: indexPath)
    }
    
    func getImage(indexPath: IndexPath) -> UIImage? {
        guard let fileType = task.attachments[indexPath.row].file?.fileType else  { return nil }
        if fileType == .notImage{
            let image = getFileImage()
            return image
        } else {
            if let image = getImageFromCache(attachmentURL: task.attachments[indexPath.row].attachmentURL) {
                return image
            }
            if let image = getImageFromData(indexPath: indexPath) {
                return image
            }
        }
        return nil
    }
    
    func getAllImages() -> [UIImage] {
        var array: [UIImage] = []
        for item in task.attachments {
            if item.file?.fileType == .some(.notImage) {
                let image = getFileImage()
                array.append(image!)
            } else {
                let image = getImageFromCache(attachmentURL: item.attachmentURL)
                array.append(image!)
            }

//            if item.file?.fileType == .some(.notImage) {
//                let image = UIImage(named: "icons8-file-50.png")
//                array.append(image!)
//            } else {
//                let image = UIImage(data: (item.file?.fileData)!)
//                array.append(image!)
//            }
        }
        
        return array
    }
    
    func generatePreviewPresenter() -> PreviewPresenterProtocol {
        return PreviewPresenter(attachments: task.attachments, parent: self.parrent as? PreviewDetailViewControllerProtocol)
    }
}
