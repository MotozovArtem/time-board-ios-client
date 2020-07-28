//
//  CommentAttachment.swift
//  time-board
//
//  Created by Tianid on 23.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class Comment: Codable {

    var commentText: String
    var commentAttachments: [Attachment]
    
    init(commentText: String, commentAttachments: [Attachment]) {
        self.commentText = commentText
        self.commentAttachments = commentAttachments
    }
}
