//
//  TBSettings.swift
//  time-board
//
//  Created by Tianid on 19.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
//MARK: debug command
//po NSHomeDirectory()

class TBSettings {
    //MARK: - Properties
    
    static let shared = TBSettings()
    private let userDefault: UserDefaults
    private let suiteName = "app.time-board-UD"
    
    //MARK: - Init

    init() {
        self.userDefault = UserDefaults(suiteName: suiteName)!
    }
    
    //MARK: - Func

    func saveUser(name: String, email: String, completion: (Result<() -> Void, Error>) -> Void) {
        self.userDefault.set(name, forKey: "User")
        self.userDefault.set(email, forKey: "Email")
        completion(.success({
            TBLog(message: "Saving in User Defaults Successed", typeOfLog: .Verbose)
        }))
    }
    
    func deleteUser(completion: (Result<() -> Void, Error>) -> Void) {
        self.userDefault.removeObject(forKey: "User")
        self.userDefault.removeObject(forKey: "Email")
        completion(.success({
            TBLog(message: "Deleting in User Defaults Successed", typeOfLog: .Info)
        }))
    }
    
    func getUser() -> String? {
        guard let user = self.userDefault.object(forKey: "User") as? String else { return nil}
        return user
    }
}
