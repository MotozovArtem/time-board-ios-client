//
//  RegistrationPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


protocol RegistrationPresenterProtocol: class {
    var registrationViewController: RegistrationViewControllerProtocol? { get set }
    func cancelButtonAction()
}
