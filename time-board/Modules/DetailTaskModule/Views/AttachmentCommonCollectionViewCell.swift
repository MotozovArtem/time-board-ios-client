//
//  AttachmentCommonCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentCommonCollectionViewCell: UICollectionViewCell, IAttachmentCell {
    
    //MARK: - Properties
    weak var presenter: IDetailTaskPresenter?
    var attachment: Attachment!
    var imageView: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    private func setupCell() {
        imageView = UIImageView(frame: self.bounds)
        contentView.addSubview(imageView!)
        
        imageView.anchor(centerX: contentView.centerXAnchor,
                         centerY: contentView.centerYAnchor)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: self.bounds.height),
            imageView.widthAnchor.constraint(equalToConstant: self.bounds.height)
        ])
        
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
    func setupImage(image: UIImage) {
        var imageWidth = image.size.width
        var imageHeight = image.size.height
        
        if image.size.width > self.imageView.frame.size.width {
            imageWidth = self.imageView.frame.size.width
        }
        
        if image.size.height > self.imageView.frame.size.height {
            imageHeight = self.imageView.frame.size.height
        }
        
//        let imageR = UIImage(ciImage: CIImage(cgImage: image.cgImage!), scale: 100, orientation: .up)
        image.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))

//        self.imageView.contentMode = .center
        self.imageView.image = image

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
