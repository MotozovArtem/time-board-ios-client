//
//  RegistrationViewController.swift
//  time-board
//
//  Created by Tianid on 20.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    //MARK: - Properties
    private lazy  var presenter: RegistrationPresenterProtocol! = {
        return RegistrationPresenter()
    }()
    
    private var registrationView: RegistrationView! {
        guard isViewLoaded else { return nil }
        return (self.view as! RegistrationView)
    }
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.registrationViewController = self
        registrationView.presenter = presenter
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        self.view = RegistrationView(frame: UIScreen.main.bounds)
    }
    
}

extension RegistrationViewController: RegistrationViewControllerProtocol {
    
    func dismissRegistrationViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func changeRootViewController() {
        DispatchQueue.main.async { [weak self] in
            self?.view.window?.rootViewController = TabBarViewController()
            self?.animateChangingVC()
        }
    }
    
    func animateChangingVC() {
        guard  let win = UIApplication.shared.keyWindow else { return }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: win, duration: duration, options: options, animations:nil, completion:nil)
    }
}
