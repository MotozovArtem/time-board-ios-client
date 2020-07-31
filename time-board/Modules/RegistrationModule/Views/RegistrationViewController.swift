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
    var presenter: IRegistrationPresenter?
    
    private var registrationView: RegistrationView! {
        guard isViewLoaded else { return nil }
        return (self.view as! RegistrationView)
    }
    
    //MARK: - Functions
    
    private func configure() {
        orientationType(.portrait)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registrationView.presenter = presenter
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = RegistrationView(frame: UIScreen.main.bounds)
    }
    
}

extension RegistrationViewController: IRegistrationViewController {
    
    func orientationType(_ orientation: UIInterfaceOrientationMask) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.orientationLock = orientation
    }
}
