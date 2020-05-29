//
//  DeleteOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import GRDB

class DeleteOperation<T: DatabaseRecordTypes>: AsyncOperation {
    
    private let driver: DatabaseDriverProtocol
    private let model: T.Type
    private let predicates: [String: DatabaseValueConvertible]
    
    init(driver: DatabaseDriverProtocol, model: T.Type = T.self, predicates: [String: Any]) {
        self.driver = driver
        self.model = model
        self.predicates = predicates.compactMapValues { DatabaseValue(value: $0) }
    }
    
    override func main() {
        deleteFromTable { [unowned self] result in
            switch result {
            case .success():
                self.finish()
                TBLog(message: "Delete operation ended", typeOfLog: .Info)
            case .failure(_):
                self.cancel()
            }
        }
    }
        
    private func deleteFromTable(complition: (Result<Void, Error>) -> Void) {
        driver.deleteFromTable(of: model, predicates: predicates, complition:complition)
    }
}
