//
//  LoginPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol ILoginPresenter: class {
    func loginViewLogInButtonAction(login: String, password: String)
    func loginViewRegisterButtonAction()
}
