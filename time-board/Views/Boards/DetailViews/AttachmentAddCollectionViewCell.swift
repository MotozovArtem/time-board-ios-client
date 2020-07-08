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
    var attachment: Attachment!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        // Initialization code
    }
    
    private func setupCell() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = .white
    }
}
