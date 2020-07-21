//
//  DetailTaskPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 06.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IDetailTaskPresenter: class {
    var task: Task { get set }
    var cache: NSCache<AnyObject, AnyObject> { get set }
    func addAttachmentTapped()
    func attachmentCellLongTapped(indexPath: IndexPath)
    func attachmentCellTapped(viewController: UIViewController)
    func addNewAttachment(data: Data, fileName: String, fileType: AttachmentFileType)
    func deleteAttachmentTapped(indexPath: IndexPath)
    func getImage(indexPath: IndexPath) -> UIImage?
    func getAllImages() -> [UIImage]
    func generatePreviewPresenter() -> IPreviewPresenter
    func descriptionLabelTapped()
}
