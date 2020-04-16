//
//  ASGroupTask.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ASGroupTask {
    
    private var id: UUID
    private var name: String
    
    init(
        id:String,
        name:String
    ) {
        self.id = UUID(uuidString: id)!
        self.name = name
    }
    
    // MARK: - getters
    func getId() -> UUID {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    // MARK: - setters
    
    func setId(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setName(name: String) {
        self.name = name
    }
}
