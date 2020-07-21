//
//  ASAccaunt.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import GRDB

typealias DatabaseRecordTypes = FetchableRecord & PersistableRecord

struct ASAccount: DatabaseRecordTypes, Codable, IModel {
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
        self.uuid = row[SQLCodingKeys.uuid.stringValue]
        self.login = row[SQLCodingKeys.login.stringValue]
        self.password = row[SQLCodingKeys.password.stringValue]
        self.email = row[SQLCodingKeys.email.stringValue]
        self.firstName = row[SQLCodingKeys.firstName.stringValue]
        self.secondName = row[SQLCodingKeys.secondName.stringValue]
        self.creationDate = row[SQLCodingKeys.creationDate.stringValue]
        self.iconUrl = row[SQLCodingKeys.iconUrl.stringValue]
        self.version = row[SQLCodingKeys.version.stringValue]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try? container.decode(String.self, forKey: .uuid)
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
        container[SQLCodingKeys.uuid.stringValue] = uuid
        container[SQLCodingKeys.login.stringValue] = login
        container[SQLCodingKeys.email.stringValue] = email
        container[SQLCodingKeys.firstName.stringValue] = firstName
        container[SQLCodingKeys.secondName.stringValue] = secondName
        container[SQLCodingKeys.creationDate.stringValue] = creationDate
        container[SQLCodingKeys.iconUrl.stringValue] = iconUrl
        container[SQLCodingKeys.version.stringValue] = version
    }
    
    enum SQLCodingKeys: String, CodingKey {
        case login,password, email, version
        case uuid = "uuid"
        case firstName = "first_name"
        case secondName = "second_name"
        case creationDate = "creation_date"
        case iconUrl = "icon_url"
    }

    enum CodingKeys: String, CodingKey {
        case uuid = "id", login, password, email, firstName, secondName, creationDate, version, iconUrl
    }
    
    func geFields() -> [String : Any?] {
        var dict = [String: Any?]()
        dict.updateValue(uuid, forKey: "uuid")
        dict.updateValue(login, forKey: "login")
        dict.updateValue(email, forKey: "email")
        dict.updateValue(firstName, forKey: "firstName")
        dict.updateValue(secondName, forKey: "secondName")
        dict.updateValue(creationDate, forKey: "creationDate")
        dict.updateValue(iconUrl, forKey: "iconUrl")
        dict.updateValue(version, forKey: "version")
        return dict
    }
}
