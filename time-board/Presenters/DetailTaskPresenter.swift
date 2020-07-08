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
        guard let data = task.attachments[indexPath.row].image?.imageData else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        let attachmentURL = task.attachments[indexPath.row].attachmentURL
        cache.setObject(image, forKey: attachmentURL as NSString)
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
    
    func addNewAttachment(imageData: Data, fileName: String) {
        let attachment = Attachment(attachmentURL: fileName)
        attachment.image = Image(withImage: imageData)
        let uiImage = UIImage(data: imageData)
        task.attachments.append(attachment)
        cache.setObject(uiImage!, forKey: fileName as NSString)
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
        if let image = getImageFromCache(attachmentURL: task.attachments[indexPath.row].attachmentURL) {
            return image
        }
        
        if let image = getImageFromData(indexPath: indexPath) {
            return image
        }
        
        return nil
    }
}
