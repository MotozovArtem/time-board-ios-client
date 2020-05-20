//
//  LoginPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


protocol LoginPresenterProtocol: class {
    var loginViewController: LoginViewControllerProtocol? { get set }
    func loginViewLogInButtonAction(login: String, password: String)
    func loginViewRegisterButtonAction()
    
}
