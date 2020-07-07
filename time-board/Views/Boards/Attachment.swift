//
//  Attachment.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class Attachment: Codable {
    var attachmentURL: String
    
    init(attachmentURL: String) {
        self.attachmentURL = attachmentURL
    }
}
