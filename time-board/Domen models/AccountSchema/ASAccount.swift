//
//  ASAccaunt.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import GRDB

typealias DatabaseRecordTypes = FetchableRecord & PersistableRecord

struct ASAccount: DatabaseRecordTypes, Codable {
    let uuid: String?
    let login: String
    let password: String?
    let email: String
    let firstName: String?
    let secondName: String?
    let creationDate: String?
    let iconUrl: String?
    let version: Int?
    
    internal init(id: String?, login: String, password: String?, email: String, firstName: String?, secondName: String?, creationDate: String?, iconUrl: String?, version: Int?) {
        self.uuid = id
        self.login = login
        self.password = password
        self.email = email
        self.firstName = firstName
        self.secondName = secondName
        self.creationDate = creationDate
        self.iconUrl = iconUrl
        self.version = version
    }
    //MARK: - Call when selected from SQLite
    init(row: Row) {
        self.uuid = row[CodingKeys.uuid.stringValue]
        self.login = row[CodingKeys.login.stringValue]
        self.password = row[CodingKeys.password.stringValue]
        self.email = row[CodingKeys.email.stringValue]
        self.firstName = row[CodingKeys.firstName.stringValue]
        self.secondName = row[CodingKeys.secondName.stringValue]
        self.creationDate = row[CodingKeys.creationDate.stringValue]
        self.iconUrl = row[CodingKeys.iconUrl.stringValue]
        self.version = row[CodingKeys.version.stringValue]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KeysForJSONDecoding.self)
        self.uuid = try? container.decode(String.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.password = try? container.decode(String.self, forKey: .password)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try? container.decode(String.self, forKey: .firstName)
        self.secondName = try? container.decode(String.self, forKey: .secondName)
        self.creationDate = try? container.decode(String.self, forKey: .creationDate)
        self.iconUrl = try? container.decode(String.self, forKey: .iconUrl)
        self.version = try? container.decode(Int.self, forKey: .version)
    }
    
    //MARK: - Call when need to save into SQLite
    func encode(to container: inout PersistenceContainer) {
        container[CodingKeys.uuid.stringValue] = uuid
        container[CodingKeys.login.stringValue] = login
        container[CodingKeys.email.stringValue] = email
        container[CodingKeys.firstName.stringValue] = firstName
        container[CodingKeys.secondName.stringValue] = secondName
        container[CodingKeys.creationDate.stringValue] = creationDate
        container[CodingKeys.iconUrl.stringValue] = iconUrl
        container[CodingKeys.version.stringValue] = version
    }
    
    enum CodingKeys: String, CodingKey {
        case login,password, email, version
        case uuid = "uuid"
        case firstName = "first_name"
        case secondName = "second_name"
        case creationDate = "creation_date"
        case iconUrl = "icon_url"
    }
    
    enum KeysForJSONDecoding: String, CodingKey {
        case id, login, password, email, firstName, secondName, creationDate, version, iconUrl
    }
    
}
