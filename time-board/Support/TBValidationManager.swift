//
//  TBValidateManager.swift
//  time-board
//
//  Created by Tianid on 21.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class TBValidationManager: IValidateManager {
    //MARK: - Properties

    private var validatableObjects: [IValidatable]?
    weak var delegate: IValidateManagerDelegate?
    
    //MARK: - Init

    init(validatableObjects: [IValidatable]) {
        self.validatableObjects = validatableObjects
        
        for item in validatableObjects {
            item.validateManager = self
        }
    }
    
    //MARK: - Func

    func verificated() {
        let value = validatableObjects?.filter({ !$0.isValid }).count == 0 ? true : false
        delegate?.switchRegistrationButtonAccesable(isValid: value)
    }
    
    
    
}
