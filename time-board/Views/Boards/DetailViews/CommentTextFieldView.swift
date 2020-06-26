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
    private let buttonHeightWidth: CGFloat = 25
    private var textField: UITextField! = {
        return UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    }()
    
    private var sendButtonView: UIView! = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        view.layer.cornerRadius = view.frame.size.width / 2
        return view
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
                         bottom: self.bottomAnchor,
                         padding: UIEdgeInsets(top: 1, left: 8, bottom: 20, right: 8),
                         size: CGSize(width: 0, height: 25)
//                         trailing:self.safeAreaLayoutGuide.trailingAnchor
        )

        
        NSLayoutConstraint.activate([
//            sendButtonView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            sendButtonView.heightAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.widthAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4),
            sendButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            sendButtonView.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        textField.backgroundColor = .yellow
        sendButtonView.backgroundColor = .blue
    }
    
    @objc private func targetViewDidTapped() {
        //STAB
    }
    
    
}
