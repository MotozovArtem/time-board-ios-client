//
//  SelfSizedTableView.swift
//  time-board
//
//  Created by Tianid on 01.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
    
//    override func reloadData() {
//      super.reloadData()
//      self.invalidateIntrinsicContentSize()
//      self.layoutIfNeeded()
//    }
    
    override var contentSize: CGSize {
        didSet {
            if oldValue != contentSize {
                
                    invalidateIntrinsicContentSize()
//                    superview?.setNeedsLayout()
//                    superview?.layoutIfNeeded()
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
