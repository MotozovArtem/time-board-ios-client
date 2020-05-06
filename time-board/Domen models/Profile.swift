//
//  Profile.swift
//  time-board
//
//  Created by Tianid on 05.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class Profile {
    // MARK: - Properties
    var email = "email@emal.com"
    var firstName = "FirstN"
    var secondName = "SecondN"
    //MARK: - Functions
}

struct ProfileStruct: Codable {    
    let id: UUID
    let login: String
    let email: String
    let firstName: String
    let secondName: String
    let creationDate: Date
    
    
    init(id: String, login: String, email: String, firstName: String, secondName: String, creationDate: Date) {
        self.id = UUID.init(uuidString: id)!
        self.login = login
        self.email = email
        self.firstName = firstName
        self.secondName = secondName
        self.creationDate = creationDate
    }
    
    
}
