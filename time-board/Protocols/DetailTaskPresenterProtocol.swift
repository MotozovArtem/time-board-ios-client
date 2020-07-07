//
//  DetailTaskPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol DetailTaskPresenterProtocol: class {
    var task: Task { get set }
    func addAttachmentTapped()
    func attachmentCellLongTapped(indexPath: IndexPath)
    func addNewAttachment()
    func deleteAttachmentTapped(indexPath: IndexPath)
}
