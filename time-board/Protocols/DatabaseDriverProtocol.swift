//
//  DatabaseDriverProtocol.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import GRDB

protocol DatabaseDriverProtocol {
    func createTable(type:DatabaseSetupType, sql: String)
    func inserIntoTable(model: PersistableRecord)
    func updateRecordIntoTable<T: DatabaseRecordTypes>(of type: T.Type, sql: String, sqlArguments: [String : DatabaseValueConvertible])
    func selectFromTable<T: DatabaseRecordTypes>(of type: T.Type) -> T?
    func deleteFromTable<T: DatabaseRecordTypes>(of type: T.Type, predicates: [String: DatabaseValueConvertible])
    func dropTable(by name: String)
}
