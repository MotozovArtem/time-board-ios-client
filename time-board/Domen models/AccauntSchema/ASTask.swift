//
//  ASTask.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ASTask {
    private var id: UUID
    private var creationDate: Date
    private var doneDate: Date?
    private var isDone: Bool
    private var description: String?
    private var name: String
    private var groupTask: ASGroupTask
    private var account: ASAccount
    
    init(
        id: String,
        creationDate: Date,
        doneDate: Date? = nil,
        isDone: Bool,
        description: String? = nil,
        name: String,
        groupTask: ASGroupTask,
        account: ASAccount
    ) {
        self.id = UUID(uuidString: id)!
        self.creationDate = creationDate
        self.doneDate = doneDate
        self.isDone = isDone
        self.description = description
        self.name = name
        self.groupTask = groupTask
        self.account = account
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getCreationDate() -> Date {
        return creationDate
    }
    
    func getDoneDate() -> Date? {
        return doneDate
    }
    
    func isDoneValue() -> Bool {
        return isDone
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getName() -> String {
        return name
    }
    
    func getGroupTask() -> ASGroupTask {
        return groupTask
    }
    
    func getAccaunt() -> ASAccount {
        return account
    }
    
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setCreationDate(creationDate: Date) {
        self.creationDate = creationDate
    }
    
    func setIsDoneValue(isDone: Bool) {
        self.isDone = isDone
    }
    
    func setDescription(description: String) {
        self.description = description
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setGroupTask(groupTask: ASGroupTask) {
        self.groupTask = groupTask
    }
    
    func setAccount(account: ASAccount) {
        self.account = account
    }
}
