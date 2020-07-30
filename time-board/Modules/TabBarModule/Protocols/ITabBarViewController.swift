//
//  ITabBarViewController.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol ITabBarViewController: UITabBarController {
    func configureTabBar(router: IRouter)
}
