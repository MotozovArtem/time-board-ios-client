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
    func createTable(sql: String, complition: (Result<Void, Error>) -> Void) {
        guard let db = db else { return }
        makeTable(dbType: db, sql: sql, complition: complition)
    }
    
    func inserIntoTable(model: PersistableRecord, complition: (Result<Void, Error>) -> Void) {
        guard let db = db else { return }
        makeInsertIntoTable(dbType: db, model: model, complition: complition)
    }
    
    func updateRecordIntoTable(sql: String, sqlArguments: [String : DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void) {
        guard let db = db else { return }
        makeUpdateRecordIntoTable(dbType: db, sql: sql, sqlArguments: sqlArguments, complition: complition)
    }
    
    func selectFromTable<T: DatabaseRecordTypes>(of type: T.Type = T.self, complition: (Result<T?, Error>) -> Void)  {
        guard let db = db else { return }
        makeSelectFromTable(dbType: db, model: type, complition: complition)
    }
    
    func deleteFromTable<T: DatabaseRecordTypes>(of type: T.Type = T.self, predicates: [String : DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void) {
        guard let db = db else { return }
        makeDeleteFromTable(dbType: db, model: type, key: predicates, complition: complition)
    }
    
    func dropTable(by name: String, complition: (Result<Void, Error>) -> Void) {
        guard let db = db else { return }
        makeDropTable(dbType: db, by: name, complition: complition)
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
    private func makeTable(dbType: DatabaseWriter, sql: String, complition: (Result<Void, Error>) -> Void) {
        do {
            try dbType.write { db in
                try db.execute(sql: sql)
                TBLog(message: "Table created", typeOfLog: .Verbose)
                complition(.success(()))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
    private func makeInsertIntoTable(dbType: DatabaseWriter, model: PersistableRecord, complition: (Result<Void, Error>) -> Void) {
        do {
            try dbType.write { db in
                try model.insert(db)
                TBLog(message: "Insertion into DB was successful", typeOfLog: .Verbose)
                complition(.success(()))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
    private func makeUpdateRecordIntoTable(dbType: DatabaseWriter, sql: String, sqlArguments:  [String: DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void) {
        
        do {
            try dbType.write { db in
                let arguments = StatementArguments(sqlArguments)
                try db.execute(sql: sql, arguments: arguments)
                TBLog(message: "Record was successfully updated", typeOfLog: .Verbose)
                complition(.success(()))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
    private func makeSelectFromTable<T: DatabaseRecordTypes>(dbType: DatabaseWriter, model: T.Type, complition: (Result<T?, Error>) -> Void) {
        
        do {
            try dbType.read{ db in
               let  records = try model.fetchOne(db)
                TBLog(message: "Record selected from DB", typeOfLog: .Verbose)
                complition(.success(records))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
    private func makeDeleteFromTable<T: DatabaseRecordTypes>(dbType: DatabaseWriter, model: T.Type, key: [String: DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void) {
        do {
            try dbType.write{ db in
                try model.filter(key: key).deleteAll(db)
                TBLog(message: "Record deleted from DB", typeOfLog: .Verbose)
                complition(.success(()))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
    private func makeDropTable(dbType: DatabaseWriter, by name: String, complition: (Result<Void, Error>) -> Void) {
        do {
            try dbType.write{ db in
                try db.drop(table: name)
                TBLog(message: "Table drop successful", typeOfLog: .Verbose)
                complition(.success(()))
            }
        } catch {
            TBLog(message: error.localizedDescription, typeOfLog: .Error)
            complition(.failure(error))
        }
    }
    
}
