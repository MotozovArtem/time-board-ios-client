//
//  ASAccaunt.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

struct ASAccount: Codable {
    
    let id: String
    let login: String
    let password: String
    let email: String
    let firstName: String
    let secondName: String
    let creationDate: String
    let iconUrl: String?
    let version: Int
    
    
    internal init(id: String, login: String, password: String, email: String, firstName: String, secondName: String, creationDate: String, iconUrl: String, version: Int) {
        self.id = id
        self.login = login
        self.password = password
        self.email = email
        self.firstName = firstName
        self.secondName = secondName
        self.creationDate = creationDate
        self.iconUrl = iconUrl
        self.version = version
    }
}
