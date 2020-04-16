//
//  PSProjectDashBoard.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSProjectDashBoard {
    private var id: UUID
    private var projectName: String
    private var projectCode: String
    private var creationDate: Date
    private var description: String?
    
    init(
        id: String,
        projectName: String,
        projectCode: String,
        creationDate: Date,
        description: String? = nil
    ) {
        self.id = UUID(uuidString: id)!
        self.projectName = projectName
        self.projectCode = projectCode
        self.creationDate = creationDate
        self.description = description
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getProjectName() -> String {
        return projectName
    }
    
    func getProjectCode() -> String {
        return projectCode
    }
    
    func getCreationDate() -> Date {
        return creationDate
    }
    
    func getDescription() -> String? {
        return description
    }
    //MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setProjectName(projectName: String) {
        self.projectName = projectName
    }
    
    func setProjectCode(projectCode: String) {
        self.projectCode = projectCode
    }
    
    func setDescription(description: String) {
        self.description = description
    }
}
