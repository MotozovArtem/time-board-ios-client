//
//  LoginViewController.swift
//  time-board
//
//  Created by Tianid on 19.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    private var presenter: LoginPresenterProtocol!
    private var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (self.view as! LoginView)
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter = LoginPresenter()
        presenter.loginViewController = self
        loginView.presenter = presenter
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
    
    
    private func configure() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func animateChangingVC() {
        guard  let win = UIApplication.shared.keyWindow else { return }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: win, duration: duration, options: options, animations:nil, completion:nil)
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func changeRootViewController() {
        DispatchQueue.main.async { [weak self] in
            self?.view.window?.rootViewController = TabBarViewController()
            self?.animateChangingVC()
        }
    }
    
    
}
