//
//  PSCommit.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSCommit {
    private var id: UUID
    private var date: Date
    private var hash: String
    private var diffUrl: String
    private var message: String
    private var author: PSProjectUser
    
    init(
        id: String,
        date: Date,
        hash: String,
        diffUrl: String,
        message: String,
        author: PSProjectUser
    ) {
        self.id = UUID(uuidString: id)!
        self.date = date
        self.hash = hash
        self.diffUrl = diffUrl
        self.message = message
        self.author = author
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getDate() -> Date {
        return date
    }
    
    func getHash() -> String {
        return hash
    }
    
    func getDiffUrl() -> String {
        return diffUrl
    }
    
    func getMessage() -> String {
        return message
    }
    
    func getAuthor() -> PSProjectUser {
        return author
    }
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func setHash(hash: String) {
        self.hash = hash
    }
    
    func setDiffUrl(diffUrl: String) {
        self.diffUrl = diffUrl
    }
    
    func setMessage(message: String) {
        self.message = message
    }
    
    func setAuthor(author: PSProjectUser) {
        self.author = author
    }
}
