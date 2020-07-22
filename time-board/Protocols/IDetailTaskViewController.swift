//
//  TaskDetailViewProtocol.swift
//  time-board
//
//  Created by Tianid on 01.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IDetailTaskViewController: class {
    func showAddNewAttachmentAlert()
    func showAttachmentCellAlert(indexPath: IndexPath)
    func showImagePreview(viewController: UIViewController)
    func addAttachmentDataAt(indexPath: IndexPath)
    func deleteAttachmentDataAt(indexPath: IndexPath)
    func showDescriptionEditScreen()
}

protocol IPreviewDetailViewController: class {
    func dissmisViewController()
}

protocol ICommentTextFieldDetailViewController: class {
    func addNewComment(comment: String)
    func showCameraController()
    func showImagePicker()
    func showDocumentPickerController()
    func addTextFieldCommentAttachmentDataAt(indexPath: IndexPath)
    func showTextFieldAttachmentCellAlert(at index: IndexPath)
}
