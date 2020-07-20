//
//  ViewController.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    //MARK: - Propertiec
    
    var textView: UITextView! = {
        let view = UITextView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var button: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push me", for: .normal)
        button.addTarget(self, action: #selector(pushButton(_:)), for: .touchUpInside)
        return button
    }()
    
    var imageView: UIImageView! = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        let image = UIImage(named: "picture1")
        imageView.image = image
        return imageView
    }()
    //MARK: - Functions
    
    @objc private func pushButton(_ sender: UIButton) {
        setupTextView()
    }
    
    private func setupTextView() {
//        let exclusionPath = UIBezierPath(rect: CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: textView.frame.width, height: imageView.frame.height))
//        textView.textContainer.exclusionPaths.append(exclusionPath)
//        textView.addSubview(imageView)
        
        let image = UIImage(named: "picture1")
        let attachment = NSTextAttachment()
        attachment.image = image
//        attachment.bounds = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height / 4)
        let oldWidth = (attachment.image?.size.width)!
        let scaleFactor = oldWidth / (textView.frame.size.width - 10)
        attachment.image = UIImage(cgImage: (attachment.image?.cgImage)!, scale: scaleFactor, orientation: .up)
        

        let attString = NSAttributedString(attachment: attachment)
        textView.textStorage.insert(attString, at: textView.selectedRange.location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        view.addSubview(textView)
        view.addSubview(button)
        
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        button.anchor(top: textView.bottomAnchor,
                      leading: view.safeAreaLayoutGuide.leadingAnchor,
                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                      trailing: view.safeAreaLayoutGuide.trailingAnchor)
     
        textView.delegate = self

    }
    
}

extension TestViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let d = try? textView.attributedText.data(from: NSRange(location: 0, length : textView.attributedText.length - 1), documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
    }
}

