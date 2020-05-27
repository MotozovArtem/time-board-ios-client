//
//  UpdateOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import GRDB

class UpdateOperation<T: DatabaseRecordTypes>: AsyncOperation {
    
    private let driver: DatabaseDriverProtocol
    private let model: T.Type
    private let sql: String
    private let sqlArguments: [String: DatabaseValueConvertible]
    
    init(driver: DatabaseDriverProtocol, model: T.Type = T.self, sql: String, sqlArguments: [String: DatabaseValueConvertible]) {
        self.driver = driver
        self.model = model
        self.sql = sql
        self.sqlArguments = sqlArguments
    }
    
    override func main() {
        updateRecordIntoTable { [unowned self] in
            self.finish()
            TBLog(message: "Update operation ended", typeOfLog: .Info)
        }
    }
    
    private func updateRecordIntoTable(complition: @escaping () -> Void) {
        driver.updateRecordIntoTable(of: model, sql: sql, sqlArguments: sqlArguments)
        complition()
    }
}
