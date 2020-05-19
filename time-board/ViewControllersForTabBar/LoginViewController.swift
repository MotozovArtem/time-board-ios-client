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
    
    private var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (self.view as! LoginView)
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
    
    
    private func configure() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
