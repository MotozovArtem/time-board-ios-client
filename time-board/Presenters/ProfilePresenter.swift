//
//  ProfilePresenter.swift
//  time-board
//
//  Created by Tianid on 04.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    weak var profileViewController: ProfileViewControllerProtocol? {
        didSet {
            profile = getProfileFromBackend()
            profileViewController?.setProfileData(profile: profile)
        }
    }
    var profile: Profile!
    
    // MARK: - Functions
    
    func tapButton() {
        profileViewController?.changeAvatarViewType()
    }
    
    private func getProfileFromBackend() -> Profile {
        return NetworkManager.shared.profileFromBackend()
    }
    
    
    
}
