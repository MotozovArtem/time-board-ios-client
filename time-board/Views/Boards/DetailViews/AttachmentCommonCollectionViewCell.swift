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
    var attachment: Attachment!
    var imageView: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupConstraints()
//        // Initialization code
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        imageView = UIImageView(frame: self.bounds)
        contentView.addSubview(imageView!)
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = .white
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
