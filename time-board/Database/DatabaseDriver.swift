//
//  DatabaseDriver.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import GRDB


enum DatabaseSetupType {
    case DatabaseQueue, DatabasePool
}

let SQLScriptASAccout = """
CREATE TABLE IF NOT EXISTS "ASAccount" (
"idi"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
"uuid"    TEXT UNIQUE,
"login"    TEXT NOT NULL,
"email"    TEXT NOT NULL,
"first_name"    TEXT,
"second_name"    TEXT,
"creation_date"    TEXT,
"version"    INTEGER,
"icon_url"    TEXT
);
"""

let SQLScriptUpdateASAccount = """
UPDATE ASAccount SET first_name = :firstName, second_name = :secondName WHERE uuid = :uuid
"""

class DatabaseDriver: DatabaseDriverProtocol {
    
    //MARK: - Properties
    private var db: DatabaseWriter? // DatabaseQueue or DatabasePool
    private var type: DatabaseSetupType
    
    //MARK: - Init
    init(setupType: DatabaseSetupType, configuration: Configuration? = nil) {
        self.type = setupType
        setupDatabase(setupType: setupType)
    }
    
    //MARK: - Public func
    func createTable(type: DatabaseSetupType, sql: String) {
        guard let db = db else { return }
        makeTable(dbType: db, sql: sql)
    }
    
    func inserIntoTable(model: PersistableRecord) {
        guard let db = db else { return }
        makeInsertIntoTable(dbType: db, model: model)
    }
    
    func updateRecordIntoTable<T: DatabaseRecordTypes>(of type: T.Type, sql: String, sqlArguments: [String : DatabaseValueConvertible]) {
        guard let db = db else { return }
        makeUpdateRecordIntoTable(dbType: db, model: type, sql: sql, sqlArguments: sqlArguments)
    }
    
    func selectFromTable<T: DatabaseRecordTypes>(of type: T.Type = T.self) -> T?  {
        guard let db = db else { return nil }
        return makeSelectFromTable(dbType: db, model: type)
    }
    
    func deleteFromTable<T: DatabaseRecordTypes>(of type: T.Type = T.self, predicates: [String : DatabaseValueConvertible]) {
        guard let db = db else { return }
        makeDeleteFromTable(dbType: db, model: type, key: predicates)
    }
    
    func dropTable(by name: String) {
        guard let db = db else { return }
        makeDropTable(dbType: db, by: name)
    }
    
    //MARK: - Setup func
    private func setupDatabase(setupType: DatabaseSetupType, configuration: Configuration? = nil) {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(TBConstants.DATABASE_NAME)
            .appendingPathExtension(TBConstants.DATABASE_EXTENSION)
        
        
        switch setupType {
        case .DatabaseQueue:
            db = setupQueue(path: databaseURL.absoluteString)
        case .DatabasePool:
            db = setupPool(path: databaseURL.absoluteString)
        }
    }
    
    private func setupQueue(path: String, configuration: Configuration? = nil) -> DatabaseQueue? {
        guard let configuration = configuration else {
            let dbQueue = try? DatabaseQueue(path: path)
            return dbQueue
        }
        let dbQueue = try? DatabaseQueue(path: path, configuration: configuration)
        return dbQueue
    }
    
    private func setupPool(path: String, configuration: Configuration? = nil) -> DatabasePool? {
        guard let configuration = configuration else {
            let dbPool = try? DatabasePool(path: path)
            return dbPool
        }
        let dbPool = try? DatabasePool(path: path, configuration: configuration)
        return dbPool
    }
    
    
    //MARK: - actions with database
    private func makeTable(dbType: DatabaseWriter, sql: String) {
        do {
            try dbType.write { db in
                try db.execute(sql: sql)
                TBLog(message: "Table created", typeOfLog: .Verbose)
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    }
    
    private func makeInsertIntoTable(dbType: DatabaseWriter, model: PersistableRecord) {
        do {
            try dbType.write { db in
                try model.insert(db)
                TBLog(message: "Insertion into DB was successful", typeOfLog: .Verbose)
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    }
    
    private func makeUpdateRecordIntoTable<T: DatabaseRecordTypes>(dbType: DatabaseWriter, model: T.Type, sql: String, sqlArguments:  [String: DatabaseValueConvertible]) {
        
        do {
            try dbType.write { db in
                let arguments = StatementArguments(sqlArguments)
                try db.execute(sql: sql, arguments: arguments)
                TBLog(message: "Record was successfully updated", typeOfLog: .Verbose)
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    }
    
    private func makeSelectFromTable<T: DatabaseRecordTypes>(dbType: DatabaseWriter, model: T.Type) -> T? {
        var records: T? = nil
        do {
            try dbType.read{ db in
                records = try model.fetchOne(db)
                TBLog(message: "Record selected from DB", typeOfLog: .Verbose)
                
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
        return records
    }
    
    private func makeDeleteFromTable<T: DatabaseRecordTypes>(dbType: DatabaseWriter, model: T.Type, key: [String: DatabaseValueConvertible]) {
        do {
            try dbType.write{ db in
                try model.filter(key: key).deleteAll(db)
                TBLog(message: "Record deleted from DB", typeOfLog: .Verbose)
                
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    }
    
    private func makeDropTable(dbType: DatabaseWriter, by name: String) {
        do {
            try dbType.write{ db in
                try db.drop(table: name)
                TBLog(message: "Table drop successful", typeOfLog: .Verbose)
                
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
        }
    }
    
}
