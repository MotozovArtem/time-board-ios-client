//
//  ASAccaunt.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ASAccount {
    private var id: UUID
    private var login: String
    private var password: String
    private var email: String
    private var firstName: String
    private var secondName: String
    private var creationDate: Date
    
    // MARK: -
    init(
        id: String,
        login: String,
        password: String,
        email: String,
        firstName: String,
        secondName: String,
        creationDate: Date
    ) {
        self.id = UUID(uuidString: id)!
        self.login = login
        self.password = password
        self.email = email
        self.firstName = firstName
        self.secondName = secondName
        self.creationDate = creationDate
    }
    
    // MARK: - getters
    func getId() -> UUID {
        return id
    }
    
    func getLogin() -> String {
        return login
    }
    
    func getPassword() -> String {
        return password
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getFirstName() -> String {
        return firstName
    }
    
    func getSecondName() -> String {
        return secondName
    }
    
    func getCreationDate() -> Date {
        return creationDate
    }

    
    // MARK: - setters

    func setID(id: String) {
        self.id = UUID(uuidString: id)!
    }
    
    func setLogin(login: String) {
        self.login = login
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func setFirstName(firstName: String) {
        self.firstName = firstName
    }
    
    func setSecondName(secondName: String) {
        self.secondName = secondName
    }
    
    func setCreationDate(date: String) {
        self.creationDate = DateFormatter().date(from: date)!
    }
}
