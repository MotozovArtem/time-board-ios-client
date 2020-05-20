//
//  RegistrationPresenter.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var registrationViewController: RegistrationViewControllerProtocol?
    
    func cancelButtonAction() {
        registrationViewController?.dismissRegistrationViewController()
    }

}
