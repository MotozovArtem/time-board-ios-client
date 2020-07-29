//
//  ProfilePresenter.swift
//  time-board
//
//  Created by Tianid on 04.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Properties
    
    private weak var parent: IProfileViewController?
    
    //MARK: - Deinit for removing observers
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveProfileFromBackend, object: AppInfo.shared)
        NotificationCenter.default.removeObserver(self, name: .didnotReceiveProfileFromBackend, object: AppInfo.shared)
    }
    //MARK: - Init
    init(view: IProfileViewController) {
        self.parent = view
        addNotificationsObservers()
    }
    
    // MARK: - Private functions
    private func setProfileForView(profile: ASAccount) {
        guard parent != nil else { return }
        DispatchQueue.main.async { [weak self] in
            guard let firstName = profile.firstName, let secondName = profile.secondName else { return }
            self?.parent?.setProfileData(email: profile.email, firstName: firstName, secondName: secondName)
            self?.parent?.showToast(message: "Profile loaded")
        }
    }
        
    // MARK: - Functions
    
    func loadProfileFromBackend() {
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
    
    func tapSettingsButton() {
        parent?.changeAvatarViewType()
    }
    
    func tapLogoutButton() {
        DatabaseManager().dropOperation(tableName: "ASAccount")
        parent?.changeRootViewController()
    }
    
    //MARK: - Notification center observers
    private func addNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProfileFromBackend(_:)), name: .didReceiveProfileFromBackend, object: AppInfo.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(didnotReceiveProfileFromBackend), name: .didnotReceiveProfileFromBackend, object: AppInfo.shared)
    }
    
    //MARK: - Notification observer handlers
    @objc private func didReceiveProfileFromBackend(_ notification: Notification) {
        setProfileForView(profile: AppInfo.profile)
    }
    
    @objc private func didnotReceiveProfileFromBackend (_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.parent?.showToast(message: "Connection error")
        }
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
