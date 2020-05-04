//
//  ProfilePresenter.swift
//  time-board
//
//  Created by Tianid on 04.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var profileViewController: ProfileViewControllerProtocol?
    
    func tapButton() {
        profileViewController?.changeAvatarViewType()
    }
    
    
}
