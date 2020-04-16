//
//  PSRole.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PSRole {
    
    private var id: UUID
    private var name: String
    private var accessLevel: Int
    
    init(
        id: String,
        name: String,
        accessLevel: Int
    ) {
        self.id = UUID(uuidString: id)!
        self.name = name
        self.accessLevel = accessLevel
    }
    
    //MARK: - getters
    
    func getId() -> UUID {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getAccessLevel() -> Int {
        return accessLevel
    }
    
    //MAR: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setAccessLevel(accessLevel: Int) {
        self.accessLevel = accessLevel
    }
}
