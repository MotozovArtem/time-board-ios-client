//
//  CommentView.swift
//  time-board
//
//  Created by Tianid on 30.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    //MARK: - Properties
    var text: String = String() {
        didSet {
            commentTextLabel.text = text
        }
    }
    private var avatarImageVIew: UIImageView! = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
    }()
    
    private var nameLabel: UILabel! = {
        let view = UILabel()
        view.text = "Name"
        return view
    }()
    
    private var dateLabel: UILabel! = {
        let view = UILabel()
        view.text = "DATE"
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        return view
    }()
    
    private var commentTextLabel: UILabel! = {
        let view = UILabel()
        view.text = "TEXT LABEL"
        view.numberOfLines = 0
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
        avatarImageVIew.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(avatarImageVIew)
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(commentTextLabel)
        
        avatarImageVIew.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                               leading: self.safeAreaLayoutGuide.leadingAnchor,
                               bottom: commentTextLabel.topAnchor,
                               trailing: nameLabel.leadingAnchor,
                               padding: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 2))
        
        NSLayoutConstraint.activate([
            avatarImageVIew.heightAnchor.constraint(equalToConstant: 50),
            avatarImageVIew.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        nameLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                         //                         leading: avatarImageVIew.trailingAnchor,
            bottom: commentTextLabel.topAnchor,
            trailing: dateLabel.leadingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 2))
        //                         centerY: avatarImageVIew.centerYAnchor)
        
        dateLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                         //                         leading: nameLabel.trailingAnchor,
            bottom: commentTextLabel.topAnchor,
            trailing: self.safeAreaLayoutGuide.trailingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 8))
        //                         centerY: nameLabel.centerYAnchor)
        
        commentTextLabel.anchor(
            //            top: avatarImageVIew.bottomAnchor,
            leading: self.safeAreaLayoutGuide.leadingAnchor,
            //                                bottom: self.bottomAnchor,
            trailing: self.safeAreaLayoutGuide.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        NSLayoutConstraint.activate([
            commentTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        
        avatarImageVIew.backgroundColor = .red
        nameLabel.backgroundColor = .green
        dateLabel.backgroundColor = .blue
        commentTextLabel.backgroundColor = .yellow
        
        commentTextLabel.text = text
    }
}
