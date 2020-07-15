//
//  ImagePreviewCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 13.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ImagePreviewCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private var scrollView: ImageScrollView!
    private var UIImaeView: UIImageView!
//    var image:  UIImage?
    var image:  UIImage? {
        didSet {
            if scrollView == nil {
                scrollView = ImageScrollView(frame: contentView.frame)
                setupImageScrollView()
            }
            self.scrollView.set(image: image!)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    func refreshCell(size: CGSize) {
        scrollView?.refreshScrollSize(size: size)
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
