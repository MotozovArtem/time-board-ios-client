//
//  DatabaseDriverProtocol.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import GRDB

protocol DatabaseDriverProtocol {
    func createTable(sql: String, complition: ((Result<Void, Error>) -> Void)?)
    func inserIntoTable(model: PersistableRecord, complition: (Result<Void, Error>) -> Void)
    func updateRecordIntoTable(sql: String, sqlArguments: [String : DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void)
    func selectFromTable<T: DatabaseRecordTypes>(of type: T.Type, complition: (Result<T, Error>) -> Void)
    func deleteFromTable<T: DatabaseRecordTypes>(of type: T.Type, predicates: [String: DatabaseValueConvertible], complition: (Result<Void, Error>) -> Void)
    func dropTable(by name: String, complition: (Result<Void, Error>) -> Void)
}
