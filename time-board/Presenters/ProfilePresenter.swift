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
            profileViewController?.setProfileData(profile: profile)
        }
    }
    var profile: Profile!
    
    // MARK: - Functions
    
    init() {
        self.profile = getProfile()
    }
    
    func tapButton() {
        profileViewController?.changeAvatarViewType()
    }
    
    
    // MARK: - Inner class functions
    private func getProfile() -> Profile {
        let dbProfile = getProfileFromDB()
        let backendProfile = getProfileFromBackend()
        
        if backendProfile != nil {
            if !checkProfileIdentity(dbProfile: dbProfile, backendProfile: backendProfile!) {
                updateLocalProfileDB(dbProfile: dbProfile)
            }
            return backendProfile!
        }
        return dbProfile
    }
    
    private func getProfileFromBackend() -> Profile? {
        return NetworkManager.shared.profileFromBackend()
    }
    
    private func getProfileFromDB() -> Profile {
        return Profile()
    }
    
    // MARK: - STAB
    private func checkProfileIdentity(dbProfile:Profile, backendProfile: Profile) -> Bool {
        return true
    }
    
    // MARK: - STAB
    private func updateLocalProfileDB(dbProfile: Profile) {
        
    }
    
    
    
}
