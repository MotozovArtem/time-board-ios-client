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
            getProfile()
        }
    }

    var profile: ASAccount! {
        didSet {
            guard profileViewController != nil else { return }
            DispatchQueue.main.async { [weak self] in
                self!.profileViewController?.setProfileData(email: self!.profile.email, firstName: self!.profile.firstName, secondName: self!.profile.secondName)
            }
        }
    }
    
    // MARK: - Functions
    
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
        
        NetworkManager.shared.getAboutAccount(of: ASAccount.self,
                                              id: TBConstants.TEST_ACCOUNT_ID,
                                              apiPath: TBConstants.API_SINGLE_ACCOUNT,
                                              scheme: TBConstants.SCHEME,
                                              successor: { [weak self] (account) in
                                                //MARK: Insert LamberJack here
                                                print(account)
                                                self?.profile = account
        },
                                              failure: { (error) in
                                                //MARK: Insert LamberJack here
                                                print("error was")
                                                showCustomErrorDesription(error: error!)
        })
        
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
