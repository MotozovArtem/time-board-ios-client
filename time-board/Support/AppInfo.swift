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
        guard let components = NetworkManager.shared.getComponents(id: TBConstants.TEST_ACCOUNT_ID,
                                                                   host: TBConstants.SERVER_HOST,
                                                                   scheme: TBConstants.SCHEME,
                                                                   port: TBConstants.SERVER_PORT,
                                                                   path: TBConstants.API_SINGLE_ACCOUNT) else { return }
        
        
        NetworkManager.shared.makeRequest(of: ASAccount.self,
                                          components: components,
                                          requestType: .GET,
                                          successor: successor,
                                          failure: failure)
    }
}
