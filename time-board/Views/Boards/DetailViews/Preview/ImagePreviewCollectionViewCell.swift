//
//  ImagePreviewCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 13.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ImagePreviewCollectionViewCell: UICollectionViewCell {
    
    private var scrollView: ImageScrollView!
    private var UIImaeView: UIImageView!
    var image:  UIImage?
//    var image:  UIImage? {
//        didSet {
//            self.scrollView.set(image: image!)
//        }
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        scrollView = ImageScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        setupImageScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//
//        
//    }
//
    
    
    func setupImageView() {
        
    }

    
    func setupImageScrollView() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    }
}
