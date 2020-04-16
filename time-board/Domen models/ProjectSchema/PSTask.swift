//
//  PSTask.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSTask {
    private var id: UUID
    private var number: Int
    private var fullCode: String
    private var creationDate: Date
    private var doneDate: Date?
    private var lastModified: Date
    private var description: String?
    private var name: String
    private var project: PSProjectDashBoard
    private var step: PSStep
    private var groupTask: PSGroupTask
    private var executer: PSProjectUser
    private var reporter: PSProjectUser
    
    init(
        id: String,
        number: Int,
        fullCode: String,
        creationDate: Date,
        doneDate: Date? = nil,
        lastModified: Date,
        description: String?,
        name: String,
        project: PSProjectDashBoard,
        step: PSStep,
        groupTask: PSGroupTask,
        executer: PSProjectUser,
        reporter: PSProjectUser
    ) {
        self.id = UUID(uuidString: id)!
        self.number = number
        self.fullCode = fullCode
        self.creationDate = creationDate
        self.doneDate = doneDate
        self.lastModified = lastModified
        self.description = description
        self.name = name
        self.project = project
        self.step = step
        self.groupTask = groupTask
        self.executer = executer
        self.reporter = reporter
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getNumber() -> Int {
        return number
    }
    
    func getFullCode() -> String {
        return fullCode
    }
    
    func getCreationDate() -> Date {
        return creationDate
    }
    
    func getDoneDate() -> Date? {
        return doneDate
    }
    
    func getLastModified() -> Date {
        return lastModified
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getName() -> String {
        return name
    }
    
    func getProject() -> PSProjectDashBoard {
        return project
    }
    
    func getStep() -> PSStep {
        return step
    }
    
    func getGroupTask() -> PSGroupTask {
        return groupTask
    }
    
    func getExecuter() -> PSProjectUser {
        return executer
    }
    
    func getReporter() -> PSProjectUser {
        return reporter
    }
    
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setNumber(number: Int) {
        self.number = number
    }
    
    func setFullCode(fullCode: String) {
        self.fullCode = fullCode
    }
    
    func setCreationDate(creationDate: Date) {
        self.creationDate = creationDate
    }
    
    func setDoneDate(doneDate: Date) {
        self.doneDate = doneDate
    }
    
    func setLastModified(lastModified: Date) {
        self.lastModified = lastModified
    }
    
    func setDescription(description: String) {
        self.description = description
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setProject(project: PSProjectDashBoard) {
        self.project = project
    }
    
    func setStep(step: PSStep) {
        self.step = step
    }
    
    func setGroupTask(groupTask: PSGroupTask) {
        self.groupTask = groupTask
    }
    
    func setExecuter(executer: PSProjectUser) {
        self.executer = executer
    }
    
    func setReporter(reporter: PSProjectUser) {
        self.reporter = reporter
    }
}
