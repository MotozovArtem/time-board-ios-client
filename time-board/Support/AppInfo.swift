//
//  AppInfo.swift
//  time-board
//
//  Created by Tianid on 13.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class AppInfo {
    static let shared = AppInfo()
    static var profile: ASAccount!
    
    func load() {
        loadProfile()
    }
    
    private func loadProfile() {
        NetworkManager.shared.getAboutAccount(of: ASAccount.self,
                                              id: TBConstants.TEST_ACCOUNT_ID,
                                              apiPath: TBConstants.API_SINGLE_ACCOUNT,
                                              scheme: TBConstants.SCHEME,
                                              successor: { (account) in
                                                //MARK: Insert LamberJack here
                                                print(account)
                                                AppInfo.profile = account
                                                NotificationCenter.default.post(name: .didReceiveProfileFromBackend, object: self)
            },
                                              failure: { (error) in
                                                //MARK: Insert LamberJack here
                                                print("error was")
                                                showCustomErrorDesription(error: error!)
                                                //MARK: call function to load from DB
                                                NotificationCenter.default.post(name: .didnotReceiveProfileFromBackend, object: self)

        })
    }
}
