//
//  UIViewController+toast.swift
//  time-board
//
//  Created by Tianid on 07.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: toastY - then large the value then greater y-coordinate, default value 3
    //MARK: toastX - then large the value then greater x-coordinate, default value 2
    //MARK: default start point of toast in bottom of screan
    
    func showToast(message : String,
                   font: UIFont,
                   toastColor: UIColor = UIColor.white,
                   toastBackground: UIColor = UIColor.black,
                   toastYmultiplayer: CGFloat = 3,
                   toastXmultiplayer: CGFloat = 2,
                   animationDuration: TimeInterval = 1.5,
                   delay: TimeInterval = 0.25,
                   options: UIView.AnimationOptions = .autoreverse ) {
        
        let toastLabel = UILabel()
        toastLabel.textColor = toastColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.backgroundColor = toastBackground

        toastLabel.clipsToBounds  =  true

        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / toastXmultiplayer),
                                  y: self.view.frame.height - (toastHeight * toastYmultiplayer),
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: animationDuration, delay: delay, options: options, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
