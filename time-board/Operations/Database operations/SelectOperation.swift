//
//  SelectOperation.swift
//  time-board
//
//  Created by Tianid on 25.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class SelectOperation<T: DatabaseRecordTypes>: AsyncOperation {
    
    private let driver: DatabaseDriverProtocol
    private let model: T.Type
    var result: T?
    
    init(driver: DatabaseDriverProtocol, model: T.Type = T.self) {
        self.driver = driver
        self.model = model
    }
    override func main() {
        selectFromTable { [unowned self] (result) in
            self.result = result
            self.finish()
            TBLog(message: "Selecet operation ended", typeOfLog: .Info)
        }
    }
    
    private func selectFromTable(complition: @escaping (T?) -> Void) {
        let result = driver.selectFromTable(of: model)
        complition(result)
    }
}
