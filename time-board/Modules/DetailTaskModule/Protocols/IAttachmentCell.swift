//
//  AttachmentCellProtocol.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IAttachmentCell: UICollectionViewCell {
    var presenter: IDetailTaskPresenter? { get set }
    var imageView: UIImageView! { get set }
    var attachment: Attachment! { get set }
}
