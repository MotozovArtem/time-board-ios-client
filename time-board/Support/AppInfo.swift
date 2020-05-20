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
    
    func load(successor: @escaping (ASAccount) -> Void, failure: @escaping (CustomEventMessages?) -> Void ) {
        loadProfile(successor: successor, failure: failure)
    }
    
    private func loadProfile(successor: @escaping (ASAccount) -> Void, failure: @escaping (CustomEventMessages?) -> Void ) {
        guard AppInfo.profile == nil else { return }
        NetworkManager.shared.getAboutAccount(of: ASAccount.self,
                                              id: TBConstants.TEST_ACCOUNT_ID,
                                              apiPath: TBConstants.API_SINGLE_ACCOUNT,
                                              scheme: TBConstants.SCHEME,
                                              successor: successor,
                                              failure: failure)
    }
}
