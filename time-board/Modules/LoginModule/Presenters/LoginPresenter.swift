//
//  LoginPresenter.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class LoginPresenter: ILoginPresenter {
    
    //MARK: - Properties
    private weak var parent: ILoginViewController?
    
    //MARK: - Init
    
    init(view: ILoginViewController) {
        self.parent = view
    }
    
    //MARK: - Functions
    func loginViewLogInButtonAction(login: String, password: String) {
        guard let id = getUserId(login: login, password: password) else { return }
        let path = String(format: TBConstants.API_SINGLE_ACCOUNT, id)
        guard let components = NetworkManager.shared.getComponents(host: TBConstants.SERVER_HOST,
                                                                   scheme: TBConstants.SCHEME,
                                                                   port: TBConstants.SERVER_PORT,
                                                                   path: path) else { return }
        
        NetworkManager.shared.makeRequest(of: ASAccount.self,
                                          components: components,
                                          requestType: .GET,
                                          successor: { [weak self] (account) in
                                            let dbManager = DatabaseManager()
                                            dbManager.createOperation(complitionHandler: {
                                                dbManager.insertOperation(model: account)
                                            })
                                            AppInfo.profile = account
                                            self?.parent?.changeRootViewController()
            },
                                          failure: { (error) in
                                            
        })
    }
    
    func loginViewRegisterButtonAction() {
        self.parent?.showRegisterViewController()
    }
    
    //MARK: - STAB
    private func checkPasswordAccount(login: String, password: String) -> Bool {
        return true
    }
    //MARK: STAB
    private func getUserId(login: String, password: String) -> String? {
        guard checkPasswordAccount(login: login, password: password) else { return nil }
        return TBConstants.TEST_ACCOUNT_ID
    }
}
