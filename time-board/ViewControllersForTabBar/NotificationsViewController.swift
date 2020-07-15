//
//  NotificationsViewController.swift
//  time-board
//
//  Created by Tianid on 01.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    
    //MARK: - Propertiec
    //MARK: - Functions
    
    private func configure() {
        view.backgroundColor = .yellow
        title = "Notifications"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        // Do any additional setup after loading the view.
    }
}
