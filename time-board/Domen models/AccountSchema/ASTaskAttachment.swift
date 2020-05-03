//
//  ASTaskAttachment.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ASTaskAttachment {
    private var id: UUID
    private var attachmentName: String
    private var url: String
    private var task: ASTask
    
    init(
        id: String,
        attachmentName: String,
        url:String,
        task: ASTask
    ) {
        self.id = UUID(uuidString: id)!
        self.attachmentName = attachmentName
        self.url = url
        self.task = task
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getAttachmentName() -> String {
        return attachmentName
    }
    
    func getUrlString() -> String {
        return url
    }
    
    func getTask() -> ASTask {
        return task
    }
    
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setAttachmentName(attachmentName: String) {
        self.attachmentName = attachmentName
    }
    
    func setUrl(url: String) {
        self.url = url
    }
    
    func setTask(task: ASTask) {
        self.task = task
    }
}
