//
//  DropOperation.swift
//  time-board
//
//  Created by Tianid on 27.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class DropOperation: AsyncOperation {
 
    private let driver: DatabaseDriverProtocol
    private let tableName: String
    
    init(driver: DatabaseDriverProtocol, tableName: String) {
        self.driver = driver
        self.tableName = tableName
    }
    
    override func main() {
        dropTable { [unowned self] in
            self.finish()
            TBLog(message: "Drop operation ended", typeOfLog: .Info)
        }
    }
    
    private func dropTable(complition: @escaping () -> Void) {
        driver.dropTable(by: tableName)
        complition()
    }
    
    
}
