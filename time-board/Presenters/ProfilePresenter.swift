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
    weak var profileViewController: ProfileViewControllerProtocol?
    
    var profile: ASAccount! {
        didSet {
            guard profileViewController != nil else { return }
            DispatchQueue.main.async { [weak self] in
                self!.profileViewController?.setProfileData(email: self!.profile.email, firstName: self!.profile.firstName, secondName: self!.profile.secondName)
                self?.profileViewController?.showToast(message: "Profile loaded")
            }
        }
    }
    
    // MARK: - Functions
    
    func tapButton() {
        profileViewController?.changeAvatarViewType()
    }
    
    //MARK: - Notification center observers
    private func addNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProfileFromBackend(_:)), name: .didReceiveProfileFromBackend, object: AppInfo.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(didnotReceiveProfileFromBackend), name: .didnotReceiveProfileFromBackend, object: AppInfo.shared)
    }
    
    //MARK: - Notification observer handlers
    @objc private func didReceiveProfileFromBackend(_ notification: Notification) {
        self.profile = AppInfo.profile
    }
    
    @objc private func didnotReceiveProfileFromBackend (_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.profileViewController?.showToast(message: "Connection error")
        }
    }
    
    //MARK: - Deinit for removing observers
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveProfileFromBackend, object: AppInfo.shared)
        NotificationCenter.default.removeObserver(self, name: .didnotReceiveProfileFromBackend, object: AppInfo.shared)
    }
    //MARK: - Init
    init() {
        defer {
            AppInfo.shared.load(successor: { (account) in
                //MARK: Insert LamberJack here
                AppInfo.profile = account
                NotificationCenter.default.post(name: .didReceiveProfileFromBackend, object: AppInfo.shared)
            }, failure: { (error) in
                //MARK: Insert LamberJack here
                //MARK: call function to load from DB
                NotificationCenter.default.post(name: .didnotReceiveProfileFromBackend, object: AppInfo.shared)
                
            })
            
        }
        addNotificationsObservers()
    }
    
    
    
    
    
    
    
    
    
    
    private func getProfileFromDB() -> ASAccount? {
        return nil
    }
    
    // MARK: - STAB
    private func checkProfileIdentity(dbProfile:ASAccount, backendProfile: ASAccount) -> Bool {
        return true
    }
    
    // MARK: - STAB
    private func updateLocalProfileDB(dbProfile: ASAccount) {
        
    }
}
