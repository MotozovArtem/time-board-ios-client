//
//  PreviewPresenter.swift
//  time-board
//
//  Created by Tianid on 15.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class PreviewPresenter: IPreviewPresenter {
    
    // MARK: - Properties

    var attachments: [Attachment]
    private weak var parent: IPreviewDetailViewController?
    
    // MARK: - Init
    
    init(attachments: [Attachment], parent: IPreviewDetailViewController?) {
        self.attachments = attachments
        self.parent = parent
    }
    
    // MARK: - Func
    
    func getActivityController(index: Int) -> UIActivityViewController? {
        let attachment = attachments[index]
        guard let file = attachment.file else { return nil }
        guard let fileType = file.fileType else { return nil }
        
        if fileType == .notImage {
            return fileActivityItem(attachment: attachment, file: file)
        }
        return imageActivityItem(file: file)
    }
    
        
    private func fileActivityItem(attachment: Attachment, file: File) -> UIActivityViewController {
        let temp = NSTemporaryDirectory() + "\(attachment.attachmentURL)"
        let url = URL(fileURLWithPath: temp)
        do {
            try file.fileData?.write(to: url)
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                do {
                    try FileManager.default.removeItem(at: url)
                } catch {
                    TBLog(message: error.localizedDescription, typeOfLog: .Error)
                }
            }
        }
        return activity
    }
    
    private func imageActivityItem(file: File) -> UIActivityViewController? {
        guard let fileData = file.fileData else { return nil }
        let image  =  UIImage(data: fileData)
        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        return activity
    }
    
}

