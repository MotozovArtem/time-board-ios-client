//
//  DetailTaskPresenter.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class DetailTaskPresenter: DetailTaskPresenterProtocol {

    private weak var parrent: DetailTaskViewControllerProtocol?
    
    init(controller: DetailTaskViewControllerProtocol) {
        self.parrent = controller
    }
    
    func addAttachmentTapped() {
        parrent?.showAddNewAttachmentAlert()
    }
    
    func attachmentCellLongTapped() {
        parrent?.showAttachmentCellAlert()
    }
    
}
