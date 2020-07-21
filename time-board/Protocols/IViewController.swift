//
//  ViewControllerProtocol.swift
//  time-board
//
//  Created by Tianid on 22.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IViewController {
    func changeRootViewController()
    func animateChangingVC()
    func orientationType(_ orientation: UIInterfaceOrientationMask)
}
