//
//  TaskDetailViewProtocol.swift
//  time-board
//
//  Created by Tianid on 01.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol DetailTaskViewControllerProtocol: class {
    func addNewComment(comment: String)
    func showAddNewAttachmentAlert()
    func showAttachmentCellAlert()
}
