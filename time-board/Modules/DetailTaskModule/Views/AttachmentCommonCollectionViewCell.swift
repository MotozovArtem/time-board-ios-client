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
        
        imageView.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
        
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
    func setupImage(image: UIImage?) {
        guard let image = image else { return }
        
        if image.size.width == 50 && image.size.height == 50 {
            self.imageView.contentMode = .center
        } else {
            self.imageView.contentMode = .scaleAspectFill
        }

        self.imageView.clipsToBounds = true
        self.imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
