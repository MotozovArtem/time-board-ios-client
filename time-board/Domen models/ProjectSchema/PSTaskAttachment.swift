//
//  PSTaskAttachment.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSTaskAttachment {
    private var id: UUID
    private var task: PSTask
    private var comment: String?
    private var attachmentName: String
    private var url: String
    
    init(
        id: String,
        task: PSTask,
        comment: String? = nil,
        attachmentName: String,
        url: String
    ) {
        self.id = UUID(uuidString: id)!
        self.task = task
        self.comment = comment
        self.attachmentName = attachmentName
        self.url = url
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getTask() -> PSTask {
        return task
    }
    
    func getComment() -> String? {
        return comment
    }
    
    func getAttachmentName() -> String {
        return attachmentName
    }
    
    func getUrl() -> String {
        return url
    }
    
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setTask(task: PSTask) {
        self.task = task
    }
    
    func setComment(comment: String) {
        self.comment = comment
    }
    
    func setAttachmentName(attachmentName: String) {
        self.attachmentName = attachmentName
    }
    
    func setUrl(url: String) {
        self.url = url
    }
}
