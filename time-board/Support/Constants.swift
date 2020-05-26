//
//  Constants.swift
//  time-board
//
//  Created by Tianid on 12.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//



private protocol TBConstantsProtocol: class {
    //MARK: - Server info
    var SERVER_HOST: String { get }
    var SERVER_PORT: Int { get }
    
    var SCHEME: String { get }
    
    var TEST_ACCOUNT_ID: String { get }
    
    var DATABASE_NAME: String { get }
    var DATABASE_EXTENSION: String { get }
    
    //MARK: - API requests with accounts
    
    var API_ALL_ACCOUNTS: String { get }
    var API_SINGLE_ACCOUNT: String { get }
}


public class TBConstants {
    
    private static let isProduction = false
    
    private enum Environment {
        case production, development
    }
    private static var environment: Environment {
        return isProduction ? .production: .development
    }
    
    
    private static var shared: TBConstantsProtocol {
        switch environment {
        case .development:
            return TBConstantsDevelopment()
        case .production:
            return TBConstantsProduction()
        }
    }
    
    static var SERVER_HOST: String { return shared.SERVER_HOST }
    static var SERVER_PORT: Int { return shared.SERVER_PORT }
    static var SERVER_ADDRESS: String { return "\(shared.SERVER_HOST):\(shared.SERVER_PORT)"}
    
    static var SCHEME: String { return shared.SCHEME }
    
    static var TEST_ACCOUNT_ID: String { return shared.TEST_ACCOUNT_ID }
    static var DATABASE_NAME: String { return shared.DATABASE_NAME }
    static var DATABASE_EXTENSION: String { return shared.DATABASE_EXTENSION }
    
    static var API_ALL_ACCOUNTS: String { "\(shared.API_ALL_ACCOUNTS)" } /* get all accounts or create new account*/
    static var API_SINGLE_ACCOUNT: String { "\(shared.API_SINGLE_ACCOUNT)" /* get/delete/update account */ }
}

private class TBConstantsProduction: TBConstantsProtocol {
    
    let SERVER_HOST = "NONE"
    let SERVER_PORT = 0
    
    let SCHEME = "http"
    
    let TEST_ACCOUNT_ID = "NONE"
    
    let DATABASE_NAME = "NONE"
    let DATABASE_EXTENSION = "NOEN"
    
    var API_ALL_ACCOUNTS = "NONE"
    var API_SINGLE_ACCOUNT = "NONE"
    
    
}

private class TBConstantsDevelopment: TBConstantsProtocol {
    let SERVER_HOST = "192.168.1.197"
    let SERVER_PORT = 8080
    
    let SCHEME = "http"
    
    let TEST_ACCOUNT_ID = "bb951eda-a219-4f39-ac90-6af6c0a6af78"
    let DATABASE_NAME = "time-board-db"
    let DATABASE_EXTENSION = "sqlite"
    
    var API_ALL_ACCOUNTS = "/api/v1/accounts/"
    var API_SINGLE_ACCOUNT = "/api/v1/accounts/%@"
}

