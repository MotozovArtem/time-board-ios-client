//
//  ProfileView.swift
//  time-board
//
//  Created by Tianid on 07.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    // MARK: - Action properties
     
    var settingsButtonAction: (() -> ())?
    var logoutButtonAction: (() -> ())?
    
    //MARK: - Properties
    var profileAvatar: UIView!
    private let profileAvatarSize : CGFloat = 75
    
    var emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var firstNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var secondNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var profileImageView: UIImageView? = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: profileAvatarSize, height: profileAvatarSize))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.image = UIImage(#imageLiteral(resourceName: "icons8-top-menu-50-2"))
        return imageView
    }()
    
    lazy var profileColoredView: UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: profileAvatarSize, height: profileAvatarSize))
        view.layer.cornerRadius = view.frame.size.width / 2
        view.backgroundColor = UIColor(red: .random(in: 0...1),
                                       green: .random(in: 0...1),
                                       blue: .random(in: 0...1),
                                       alpha: 1.0)
        return view
    }()
    
    var settingsButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
        //        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        return button
    }()
    
    var logoutButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    private func configure() {
        self.backgroundColor = .white
        configureProfileLabelsAndImageView()
    }
    
    private func configureProfileLabelsAndImageView() {
        profileAvatar = chooseAvatarInstanse(imageView: false)
        
        self.addSubview(profileAvatar)
        self.addSubview(emailLabel)
        self.addSubview(firstNameLabel)
        self.addSubview(secondNameLabel)
        self.addSubview(settingsButton)
        self.addSubview(logoutButton)
        
        emailLabel.textColor = .gray
        
        configureConstraint()
        
        
    }
    
    func configureConstraint() {
        
        profileAvatar.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileAvatar.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                             leading: self.safeAreaLayoutGuide.leadingAnchor,
                             padding: .init(top: 5, left: 5, bottom: 0, right: 0),
                             size: .init(width: profileAvatarSize, height: profileAvatarSize))
        
        firstNameLabel.anchor(top: profileAvatar.topAnchor,
                              leading: profileAvatar.trailingAnchor,
                              padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        
        secondNameLabel.anchor(top: firstNameLabel.bottomAnchor,
                               leading: firstNameLabel.leadingAnchor,
                               padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        emailLabel.anchor(top: secondNameLabel.bottomAnchor,
                          leading: secondNameLabel.leadingAnchor,
                          padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        settingsButton.anchor(top: profileAvatar.bottomAnchor,
                              leading: profileAvatar.leadingAnchor,
                              padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                              size: .init(width: 160, height: 30))
        
        logoutButton.anchor(top: settingsButton.bottomAnchor,
                            leading: profileAvatar.leadingAnchor,
                            padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                            size: .init(width: 160, height: 30))
    }
    
    
    func chooseAvatarInstanse(imageView: Bool) -> UIView {
        // MARK: if avatar is set (false) then choose the UIImageView with UIIamge, else (true) then add subview like UIView with random color
        // MARK: "if true" need to be change in next
        if !imageView {
            print("Colored View")
            return profileColoredView!
        } else {
            print("Image View")
            return profileImageView!
        }
    }
    
    @objc private func tapSettingsButton() {
        settingsButtonAction?()
    }
    
    @objc private func tapLogoutButton() {
        logoutButtonAction?()
    }
    
    
}
