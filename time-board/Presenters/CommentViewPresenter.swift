//
//  CommentViewPresenter.swift
//  time-board
//
//  Created by Tianid on 23.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

class CommentViewPresenter: ICommentViewPresenter {
    
    //MARK: - Properties
    var comment: Comment
    var cache: NSCache<AnyObject, AnyObject>
    
    //MARK: - Init
    init(comment: Comment) {
        self.comment = comment
        self.cache = NSCache()
    }
    
    func getImage(indexPath: IndexPath) -> UIImage? {
        guard let fileType = comment.commentAttachments[indexPath.row].file?.fileType else  { return nil }
        if fileType == .notImage{
            let image = getFileImage()
            return image
        } else {
            if let image = getImageFromCache(attachmentURL: comment.commentAttachments[indexPath.row].attachmentURL) {
                return image
            }
            if let image = getImageFromData(indexPath: indexPath) {
                return image
            }
        }
        return nil
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
        guard let data = comment.commentAttachments[indexPath.row].file?.fileData else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        let attachmentURL = comment.commentAttachments[indexPath.row].attachmentURL
        cache.setObject(image, forKey: attachmentURL as NSString)
        return image
    }
    
}
