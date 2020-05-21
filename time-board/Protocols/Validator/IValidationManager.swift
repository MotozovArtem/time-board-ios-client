//
//  IValidationManager.swift
//  time-board
//
//  Created by Tianid on 21.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IValidateManager: class {
    func verificated()
    var delegate: IValidateManagerDelegate? { get set }
}
