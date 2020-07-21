//
//  InsertOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class InsertOperation: AsyncOperation {
    
    private let driver: IDatabaseDriver
    private let model: DatabaseRecordTypes
    
    init(driver: IDatabaseDriver, model: DatabaseRecordTypes) {
        self.driver = driver
        self.model = model
    }
    
    override func main() {
        inserIntoTable(complition: { [unowned self] result in
            switch result {
            case .success():
                self.finish()
                TBLog(message: "Insert operation ended", typeOfLog: .Info)
            case .failure(_):
                self.cancel()
            }
        })
    }
    
    private func inserIntoTable(complition: (Result<Void, Error>) -> Void) {
        driver.inserIntoTable(model: model, complition: complition)
    }
}
