//
//  RegistrationPresenter.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


class RegistrationPresenter: IRegistrationPresenter {
    // MARK: - Properties
    private let router: IRouter
    private weak var parent: IRegistrationViewController?
    
    //MARK: - Init
    
    init(view: IRegistrationViewController, router: IRouter) {
        self.parent = view
        self.router = router
    }
    
    // MARK: - Func
    
    func cancelButtonAction() {
        router.dismissRegistrationViewController()
    }
    
    func registerButtonAction(login: String, email: String, password: String, firstName: String, secondName: String) {
        
        let account = ASAccount(id: nil,
                                login: login,
                                password: password,
                                email: email,
                                firstName: firstName,
                                secondName: secondName,
                                creationDate: nil,
                                iconUrl: nil,
                                version: nil)
        
        guard  let components = NetworkManager.shared.getComponents(
            host: TBConstants.SERVER_HOST,
            scheme: TBConstants.SCHEME,
            port: TBConstants.SERVER_PORT,
            path: TBConstants.API_ALL_ACCOUNTS) else { return }
        
        NetworkManager.shared.makeRequest(model: account,
                                          components: components,
                                          request: .POST) { [weak self] (result) in
                                            switch result {
                                            case .success(_):
                                                DatabaseManager().insertOperation(model: account)
                                                AppInfo.profile = account
                                                self?.router.makeLogin()
                                            case .failure(let error):
                                                TBLog(messageType: error, typeOfLog: .Error)
                                            }
        }
    }
}
