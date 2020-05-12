//
//  Constants.swift
//  time-board
//
//  Created by Tianid on 12.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//



private protocol TBConstantsProtocol: class {
    //MARK: - Server info
    var SERVER_IP: String { get }
    var SERVER_PORT: String { get }
    
    var SCHEME: String { get }
    
    var TEST_ACCOUNT_ID: String { get }
    
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
    
    static var SERVER_IP: String { return shared.SERVER_IP }
    static var SERVER_PORT: String { return shared.SERVER_PORT }
    static var SERVER_ADDRESS: String { return "\(shared.SERVER_IP):\(shared.SERVER_PORT)"}
    
    static var SCHEME: String { return shared.SCHEME }
    
    static var TEST_ACCOUNT_ID: String { return shared.TEST_ACCOUNT_ID }
    
    static var API_ALL_ACCOUNTS: String { "\(SERVER_ADDRESS)\(shared.API_ALL_ACCOUNTS)" } /* get all accounts or create new account*/
    static var API_SINGLE_ACCOUNT: String { "\(SERVER_ADDRESS)\(shared.API_SINGLE_ACCOUNT)" /* get/delete/update account */ }
}

private class TBConstantsProduction: TBConstantsProtocol {
    
    let SERVER_IP = "NONE"
    let SERVER_PORT = "NONE"
    
    let SCHEME = "http"
    
    let TEST_ACCOUNT_ID = "NONE"
    
    var API_ALL_ACCOUNTS = "NONE"
    var API_SINGLE_ACCOUNT = "NONE"
    
    
}

private class TBConstantsDevelopment: TBConstantsProtocol {
    let SERVER_IP = "192.168.1.197"
    let SERVER_PORT = "8080"
    
    let SCHEME = "http"
    
    let TEST_ACCOUNT_ID = "bb951eda-a219-4f39-ac90-6af6c0a6af78"
    
    var API_ALL_ACCOUNTS = "/api/v1/accounts/"
    var API_SINGLE_ACCOUNT = "/api/v1/accounts/%@"
}

