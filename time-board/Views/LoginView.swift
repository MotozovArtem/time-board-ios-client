//
//  LoginView.swift
//  time-board
//
//  Created by Tianid on 19.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    //MARK: - Properties
    private var loginTextField: TBTextField!
    private var passwordTextField: TBTextField!
    private var loginButton: UIButton! = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private var registerButton: UIButton!  = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(registerAction(_:)), for: .touchUpInside)
        return button
    }()
    
    weak var presenter: LoginPresenterProtocol?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        self.backgroundColor = .white
        loginTextField = TBTextField(fieldType: .loginRegEx, frame: CGRect(x: 0, y: 0, width:  100, height: 30))
        passwordTextField = TBTextField(fieldType: .passwordRegEx, frame: CGRect(x: 0, y: 0, width:  100, height: 30))
        
        loginTextField.placeholder = "Login"
        loginTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        loginButton.setTitle("Log In", for: .normal)
        registerButton.setTitle("Register", for: .normal)
        
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        
        loginTextField.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 100, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: 30),
                              centerX: self.centerXAnchor)
        
        passwordTextField.anchor(top: self.loginTextField.bottomAnchor,
                                 leading: self.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: nil,
                                 trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                 padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                                 size: .init(width: 0, height: 30),
                                 centerX: self.centerXAnchor)
        
        loginButton.anchor(top: self.passwordTextField.bottomAnchor,
                           leading: self.safeAreaLayoutGuide.leadingAnchor,
                           bottom: nil,
                           trailing: self.safeAreaLayoutGuide.trailingAnchor,
                           padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                           size: .init(width: 0, height: 30),
                           centerX: self.centerXAnchor)
        
        registerButton.anchor(top: self.loginButton.bottomAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: 30),
                              centerX: self.centerXAnchor)
        
    }
    
    
    //MARK: - Handlers
    
    @objc private func loginAction(_ sender: UIButton) {
        guard let presenter = presenter else { return }
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        presenter.loginViewLogInButtonAction(login: login, password: password)
        //        window?.rootViewController = TabBarViewController()
        //        animateChangingVC()
    }
    
    @objc private func registerAction(_ sender: UIButton) {
        presenter?.loginViewRegisterButtonAction()
        
    }
    
    
    
    
}
