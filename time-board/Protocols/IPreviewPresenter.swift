//
//  PreviewPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 15.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol IPreviewPresenter: class {
    var attachments: [Attachment] { get set }
    func getActivityController(index: Int) -> UIActivityViewController?
    func showPreview(viewController: UIViewController)
}
