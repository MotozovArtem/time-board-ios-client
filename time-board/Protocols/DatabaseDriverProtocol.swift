//
//  DatabaseDriverProtocol.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import GRDB

protocol DatabaseDriverProtocol {
    func createTable(type:DatabaseSetupType, sql: String, complition: (Result<Void, Error>) -> Void)
    func inserIntoTable(model: PersistableRecord, complition: (Result<Void, Error>) -> Void)
    func updateRecordIntoTable<T: DatabaseRecordTypes>(of type: T.Type, sql: String, sqlArguments: [String : DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void)
    func selectFromTable<T: DatabaseRecordTypes>(of type: T.Type, complition: (Result<T?, Error>) -> Void)
    func deleteFromTable<T: DatabaseRecordTypes>(of type: T.Type, predicates: [String: DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void)
    func dropTable(by name: String, complition: (Result<Void, Error>) -> Void)
}
