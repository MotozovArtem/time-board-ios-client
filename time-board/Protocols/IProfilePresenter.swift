//
//  ProfilePresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 04.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IProfilePresenter {
    var profileViewController: IProfileViewController? { get set }
    func tapSettingsButton()
    func tapLogoutButton()
}
