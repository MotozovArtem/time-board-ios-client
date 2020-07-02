//
//  AttachmentAddCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 02.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentAddCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        // Initialization code
    }
    
    @objc private func imageTapped() {
        print("Tap")
    }

}
