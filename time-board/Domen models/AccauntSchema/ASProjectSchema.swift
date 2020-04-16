//
//  ASProjectSchema.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ASProjectSchema {
    private var id: UUID
    private var userInProject: UUID?
    private var projectSchema: String
    
    
    init(
        id: String,
        userInProject: UUID?,
        projectSchema: String
    ) {
        self.id = UUID(uuidString: id)!
        self.userInProject = userInProject
        self.projectSchema = projectSchema
        
    }
    
    // MARK: - getters
    func getId() -> UUID {
        return id
    }
    
    func getUserInProject() -> UUID? {
        return userInProject
    }
    
    func getProjectSchema() -> String {
        return projectSchema
    }
    
    // MARK: - setters
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setUserInProject(userInProject: String) {
        self.userInProject = UUID(uuidString: userInProject)
    }
    
    func setProjectSchema(projectSchema: String) {
        self.projectSchema = projectSchema
    }
}

