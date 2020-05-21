//
//  RegistrationView.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

class RegistrationView: UIView {
    //MARK: - Properties
    private var loginTextField: TBTextField!
    private var passwordTextField: TBTextField!
    private var emailTextField: TBTextField!
    
    private var validationManager: IValidateManager?
    
    private var registrationButton: UIButton! = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(registrationButtonAction(_:)), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private var cancelButton: UIButton! = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    
    weak var presenter: RegistrationPresenterProtocol?
    
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
        emailTextField = TBTextField(fieldType: .emailRegEx, frame: CGRect(x: 0, y: 0, width:  100, height: 30))
        
        loginTextField.placeholder = "Login"
        loginTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        registrationButton.setTitle("Register", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        

        validationManager = TBValidationManager(validatableObjects: [loginTextField, passwordTextField, emailTextField])
        validationManager?.delegate = self
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(registrationButton)
        self.addSubview(cancelButton)
        
        loginTextField.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 100, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: 30))
        
        emailTextField.anchor(top: self.loginTextField.bottomAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                              size: .init(width: 0, height: 30))
        
        passwordTextField.anchor(top: self.emailTextField.bottomAnchor,
                                 leading: self.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: nil,
                                 trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                 padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                                 size: .init(width: 0, height: 30))
        
        registrationButton.anchor(top: self.passwordTextField.bottomAnchor,
                                  leading: self.safeAreaLayoutGuide.leadingAnchor,
                                  bottom: nil,
                                  trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                  padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                                  size: .init(width: 0, height: 30))
        
        cancelButton.anchor(top: self.registrationButton.bottomAnchor,
                            leading: self.safeAreaLayoutGuide.leadingAnchor,
                            bottom: nil,
                            trailing: self.safeAreaLayoutGuide.trailingAnchor,
                            padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                            size: .init(width: 0, height: 30))
    }
    
    //MARK: - Handlers
    
    @objc private func registrationButtonAction(_ sender: UIButton) {
        
    }
    
    @objc private func cancelButtonAction(_ sender: UIButton) {
        guard let presenter = presenter else { return }
        presenter.cancelButtonAction()
    }
}

extension RegistrationView: IValidateManagerDelegate {
    func switchRegistrationButtonAccesable(isValid: Bool) {
        registrationButton.isEnabled = isValid ? true : false
    }
}
