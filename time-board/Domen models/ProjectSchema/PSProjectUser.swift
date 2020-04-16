//
//  PSProjectUser.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSProjectUser {
    private var id : UUID
    private var projectSchema: ASProjectSchema
    private var joinigDate: Date
    private var leavingDate: Date?
    private var project: PSProjectDashBoard
    
    init(
        id: String,
        projectSchema: ASProjectSchema,
        joinigDate: Date,
        leavingDate: Date? = nil,
        project: PSProjectDashBoard
    ) {
        self.id = UUID(uuidString: id)!
        self.projectSchema = projectSchema
        self.joinigDate = joinigDate
        self.leavingDate = leavingDate
        self.project = project
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getProjectSchema() -> ASProjectSchema {
        return projectSchema
    }
    
    func getJoiningDate() -> Date {
        return joinigDate
    }
    
    func getleavingdate() -> Date? {
        return leavingDate
    }
    
    func getProject() -> PSProjectDashBoard {
        return project
    }
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setProjectSchema(projectSchema: ASProjectSchema) {
        self.projectSchema = projectSchema
    }
    
    func setJoiningDate(joiningDate: Date) {
        self.joinigDate = joiningDate
    }
    
    func setLeavingDate(leavingDate: Date) {
        self.leavingDate = leavingDate
    }
    
    func setProject(project: PSProjectDashBoard) {
        self.project = project
    }
}
