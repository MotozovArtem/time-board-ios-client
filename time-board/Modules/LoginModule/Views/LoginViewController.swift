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
    var presenter: ILoginPresenter?
    
    private var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (self.view as! LoginView)
    }
    
    //MARK: - Functions
    
    private func configure() {
        orientationType(.portrait)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loginView.presenter = presenter
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
}

extension LoginViewController: ILoginViewController {
    
    func orientationType(_ orientation: UIInterfaceOrientationMask) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.orientationLock = orientation
    }
    
}
