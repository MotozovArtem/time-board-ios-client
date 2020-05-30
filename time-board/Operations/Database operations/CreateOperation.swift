//
//  CreateOperation.swift
//  time-board
//
//  Created by Tianid on 27.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class CreateOperation: AsyncOperation {
    
    private let driver: DatabaseDriverProtocol
    private let sql: String
    
    init(driver: DatabaseDriverProtocol, sql: String) {
        self.driver = driver
        self.sql = sql
    }
    
    override func main() {
        createTable(complition: { [unowned self] result in
            switch result {
            case .success():
                self.finish()
                TBLog(message: "Create operation ended", typeOfLog: .Info)
            case .failure(_):
                self.cancel()
            }
        })
    }
    
    private func createTable(complition: ((Result<Void, Error>) -> Void)?) {
        driver.createTable(sql: sql, complition: complition)
    }
}

