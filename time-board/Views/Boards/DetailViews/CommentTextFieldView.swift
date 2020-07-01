//
//  CommentTextFieldView.swift
//  time-board
//
//  Created by Tianid on 26.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CommentTextFieldView: UIView {
    
    //MARK: - Properties
    weak var parentController: DetailViewControllerProtocol?
    private let buttonHeightWidth: CGFloat = 25
    private var textField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Type a comment..."
        return textField
    }()
    
    private var sendButtonView: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "icons8-paper-plane-50"))
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        return imageView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    private func setup() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textField)
        self.addSubview(sendButtonView)
        
        textField.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                         leading: self.safeAreaLayoutGuide.leadingAnchor,
                         bottom: self.safeAreaLayoutGuide.bottomAnchor,
                         padding: UIEdgeInsets(top: 1, left: 8, bottom: 0, right: 8)
        )
        
        
        NSLayoutConstraint.activate([
            //                        sendButtonView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            //                        sendButtonView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            sendButtonView.heightAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.widthAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4),
            sendButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            sendButtonView.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sendButtonTapped(_:)))
        sendButtonView.addGestureRecognizer(gesture)
        
        self.backgroundColor = .white
    }
    
    @objc private func sendButtonTapped(_ :UITapGestureRecognizer) {
        //STAB
        guard let comment = textField.text, comment.count > 0 else { return }
        textField.text = nil
        parentController?.addNewComment(comment: comment)
        
    }
    
    
}
