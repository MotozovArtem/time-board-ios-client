//
//  LoginPresenter.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class LoginPresenter: LoginPresenterProtocol {
    
    //MARK: - Properties
    weak var loginViewController: LoginViewControllerProtocol?
    
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
                                            TBSettings.shared.saveUser(name: login,
                                                                       email: account.email) { (result) in
                                                                        switch result {
                                                                        case .success(let clusure):
                                                                            clusure()
                                                                        case .failure(_):
                                                                            break
                                                                        }
                                            }
                                            self?.loginViewController?.changeRootViewController()
            },
                                          failure: { (error) in
                                            
        })
    }
    
    func loginViewRegisterButtonAction() {
        self.loginViewController?.showRegisterViewController()
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
