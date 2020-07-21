//
//  UpdateOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import GRDB

class UpdateOperation: AsyncOperation {
    
    private let driver: IDatabaseDriver
    private let sql: String
    private let sqlArguments: [String: DatabaseValueConvertible]
    
    init(driver: IDatabaseDriver, sql: String, sqlArguments: [String: Any?]) {
        self.driver = driver
        self.sql = sql
        self.sqlArguments = sqlArguments.compactMapValues { $0 != nil ? DatabaseValue(value: $0!) : nil }
    }
    
    override func main() {
        updateRecordIntoTable { [unowned self] result in
            switch result {
            case .success():
                self.finish()
                TBLog(message: "Update operation ended", typeOfLog: .Info)
            case .failure(_):
                self.cancel()
            }
        }
    }
    
    private func updateRecordIntoTable(complition: (Result<Void, Error>) -> Void) {
        driver.updateRecordIntoTable(sql: sql, sqlArguments: sqlArguments, complition: complition)
    }
}
