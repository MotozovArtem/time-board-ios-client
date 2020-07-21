//
//  AttachmentAddCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 02.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentAddCollectionViewCell: UICollectionViewCell, IAttachmentCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    weak var presenter: IDetailTaskPresenter?
    var attachment: Attachment!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        // Initialization code
    }
    
    //MARK: - Func
    private func setupCell() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = .white
    }
}
