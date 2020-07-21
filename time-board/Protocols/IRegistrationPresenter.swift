//
//  RegistrationPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


protocol IRegistrationPresenter: class {
    var registrationViewController: IRegistrationViewController? { get set }
    func cancelButtonAction()
    func registerButtonAction(login: String, email: String, password: String, firstName: String, secondName: String)
}
