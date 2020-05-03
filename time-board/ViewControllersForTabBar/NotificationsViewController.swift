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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        view.backgroundColor = .yellow
        title = "Notifications"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
