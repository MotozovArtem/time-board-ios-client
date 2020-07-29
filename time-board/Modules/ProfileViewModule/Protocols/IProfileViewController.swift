//
//  ProfileViewControllerProtocol.swift
//  time-board
//
//  Created by Tianid on 04.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IProfileViewController: class, IViewController {
    func changeAvatarViewType()
    func setProfileData(email: String, firstName: String, secondName: String)
    func showToast(message: String)
}
