//
//  InsertOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class InsertOperation: AsyncOperation {
    
    private let driver: DatabaseDriverProtocol
    private let model: DatabaseRecordTypes
    
    init(driver: DatabaseDriverProtocol, model: DatabaseRecordTypes) {
        self.driver = driver
        self.model = model
    }
    
    override func main() {
        inserIntoTable(complition: { [unowned self] in
            self.finish()
            TBLog(message: "Insert operation ended", typeOfLog: .Info)
        })
    }
    
    private func inserIntoTable(complition: @escaping () ->Void) {
        driver.inserIntoTable(model: model)
        complition()
    }
}
