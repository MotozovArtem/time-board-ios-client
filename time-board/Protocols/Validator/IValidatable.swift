//
//  IValidate.swift
//  time-board
//
//  Created by Tianid on 21.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IValidatable: class {
    var isValid: Bool { get }
    var validateManager: IValidateManager? { get set }
}
