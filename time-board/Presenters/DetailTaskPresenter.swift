//
//  DetailTaskPresenter.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class DetailTaskPresenter {
    var task: Task
    
    private weak var parrent: DetailTaskViewControllerProtocol?
    
    init(controller: DetailTaskViewControllerProtocol, task: Task) {
        self.parrent = controller
        self.task = task
    }
}

extension DetailTaskPresenter: DetailTaskPresenterProtocol {
    
    func addAttachmentTapped() {
        parrent?.showAddNewAttachmentAlert()
    }
    
    func attachmentCellLongTapped(indexPath: IndexPath) {
        parrent?.showAttachmentCellAlert(indexPath: indexPath)
    }
    
    func addNewAttachment() {
        task.attachments.append(Attachment(attachmentURL: "Some attachment"))
        let indexPath = IndexPath(item: task.attachments.count - 1, section: 1)
        parrent?.addAttachmentDataAt(indexPath: indexPath)
    }
    
    func deleteAttachmentTapped(indexPath: IndexPath) {
        task.attachments.remove(at: indexPath.row)
        parrent?.deleteAttachmentDataAt(indexPath: indexPath)
    }
}
