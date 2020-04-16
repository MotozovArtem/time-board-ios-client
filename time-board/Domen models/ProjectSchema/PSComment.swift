//
//  PSComment.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSComment {
    private var id: UUID
    private var task: PSTask
    private var creationDate: Date
    private var lastModified: Date
    private var author: PSProjectUser
    private var commentText: String
    
    init(
        id: String,
        task: PSTask,
        creationDate: Date,
        lastModified: Date,
        author: PSProjectUser,
        commentText: String
    ) {
        self.id = UUID(uuidString: id)!
        self.task = task
        self.creationDate = creationDate
        self.lastModified = lastModified
        self.author = author
        self.commentText = commentText
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getTask() -> PSTask {
        return task
    }
    
    func getCreationDate() -> Date {
        return creationDate
    }
    
    func getLastModified() -> Date {
        return lastModified
    }
    
    func getAuthor() -> PSProjectUser {
        return author
    }
    
    func getCommentText() -> String {
        return commentText
    }
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setTask(task: PSTask) {
        self.task = task
    }
    
    func setCreationDate(creationDate: Date) {
        self.creationDate = creationDate
    }
    
    func setLastMoified(lastModified: Date) {
        self.lastModified = lastModified
    }
    
    func setAuthor(author: PSProjectUser) {
        self.author = author
    }
    
    func setCommentText(commentText: String) {
        self.commentText = commentText
    }
}
