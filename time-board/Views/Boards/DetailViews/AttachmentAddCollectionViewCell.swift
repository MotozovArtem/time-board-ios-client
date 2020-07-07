//
//  AttachmentAddCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 02.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentAddCollectionViewCell: UICollectionViewCell, AttachmentCellProtocol {
    @IBOutlet weak var imageView: UIImageView!
    weak var presenter: DetailTaskPresenterProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
