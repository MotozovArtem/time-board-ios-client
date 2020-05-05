//
//  NetworkManager.swift
//  time-board
//
//  Created by Tianid on 05.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

enum NetworkError {
    case NoInternetConnection
    case ClienSiteError
    case ServerSiteError
}




class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Functions
    
    func profileFromBackend() -> Profile {
        // MARK: STAB
        return Profile()
    }
}
