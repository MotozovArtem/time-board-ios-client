//
//  AttachmentCommonCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentCommonCollectionViewCell: UICollectionViewCell, AttachmentCellProtocol {
    weak var presenter: DetailTaskPresenterProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
