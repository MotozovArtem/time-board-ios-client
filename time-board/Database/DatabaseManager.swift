//
//  DatabaseManager.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class DatabaseManager {
    
    private var operationQueue: OperationQueue
    private var driver: DatabaseDriverProtocol
    
    init() {
        self.operationQueue = OperationQueue()
        self.driver = DatabaseDriver(setupType: .DatabaseQueue)
    }
    
    func updateOperation(model: ModelProtocol, complitionHandler: (() -> Void)? = nil) {
        let sqlArguments = model.geFields()
        let updateOP = UpdateOperation(driver: driver, sql: SQLScriptUpdateASAccount, sqlArguments: sqlArguments)
        updateOP.completionBlock = complitionHandler
        operationQueue.addOperation(updateOP)
    }
    
    func createOperation(complitionHandler: (() -> Void)? = nil) {
        let createOP = CreateOperation(driver: driver, sql: SQLScriptCreateASAccout)
        createOP.completionBlock = complitionHandler
        operationQueue.addOperation(createOP)
    }
    
    func insertOperation(model: DatabaseRecordTypes, complitionHandler: (() -> Void)? = nil) {
        let insertOP = InsertOperation(driver: driver, model: model)
        insertOP.completionBlock = complitionHandler
        operationQueue.addOperation(insertOP)
    }
    
    func selectOperation<T: DatabaseRecordTypes>(model: T.Type = T.self, complitionHandler: ((SelectOperation<T>) -> Void)? = nil) {
        let selectOP = SelectOperation(driver: driver, model: model)
        selectOP.completionBlock = {
            complitionHandler?(selectOP)
        }
        operationQueue.addOperation(selectOP)
    }
    
    func dropOperation(tableName: String, complitionHandler: (() -> Void)? = nil) {
        let dropOP = DropOperation(driver: driver, tableName: tableName)
        dropOP.completionBlock = complitionHandler
        operationQueue.addOperation(dropOP)
    }
    
    func deleteOperation<T: DatabaseRecordTypes>(predicates: [String: Any], model: T.Type = T.self, complitionHandler: (() -> Void)? = nil) {
        let deleteOP = DeleteOperation(driver: driver, model: model, predicates: predicates)
        deleteOP.completionBlock = complitionHandler
        operationQueue.addOperation(deleteOP)
    }
}
