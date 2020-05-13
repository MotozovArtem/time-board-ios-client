//
//  Notification+types.swift
//  time-board
//
//  Created by Tianid on 13.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
    static let didReceiveProfileFromBackend = Notification.Name("didReceiveProfileFromBackend")
    static let didnotReceiveProfileFromBackend = Notification.Name("didnotReceiveProfileFromBackend")

}
