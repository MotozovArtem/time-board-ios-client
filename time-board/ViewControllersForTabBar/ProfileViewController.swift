//
//  ProfileViewController.swift
//  time-board
//
//  Created by Tianid on 01.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Propertiec
    private lazy  var presenter: ProfilePresenterProtocol! = {
        return ProfilePresenter()
    }()
    
    private var profileAvatar: UIView!
    private let profileAvatarSize : CGFloat = 75
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var firstNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var secondNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var profileImageView: UIImageView? = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: profileAvatarSize, height: profileAvatarSize))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.image = UIImage(#imageLiteral(resourceName: "icons8-top-menu-50-2"))
        return imageView
    }()
    
    private lazy var profileColoredView: UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: profileAvatarSize, height: profileAvatarSize))
        view.layer.cornerRadius = view.frame.size.width / 2
        view.backgroundColor = UIColor(red: .random(in: 0...1),
                                       green: .random(in: 0...1),
                                       blue: .random(in: 0...1),
                                       alpha: 1.0)
        return view
    }()
    
    private var settingsButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
//        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        return button
    }()
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.profileViewController = self
        configure()
        
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        view.backgroundColor = .white
        title = "Profile"
        configureProfileLabelsAndImageView()
    }
    
    private func configureProfileLabelsAndImageView() {
        profileAvatar = chooseAvatarInstanse(imageView: false)
        
        view.addSubview(profileAvatar)
        view.addSubview(emailLabel)
        view.addSubview(firstNameLabel)
        view.addSubview(secondNameLabel)
        view.addSubview(settingsButton)
        
//        emailLabel.text = "email"
        emailLabel.textColor = .gray
//        firstNameLabel.text = "first name"
//        secondNameLabel.text  = "second name"
        
        configureConstraint()
        
        
    }
    
    private func configureConstraint() {
        
        profileAvatar.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            profileAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            profileAvatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            profileAvatar.heightAnchor.constraint(equalToConstant: profileAvatarSize),
            profileAvatar.widthAnchor.constraint(equalToConstant: profileAvatarSize),
            
            firstNameLabel.topAnchor.constraint(equalTo: profileAvatar.topAnchor, constant: 5),
            firstNameLabel.leadingAnchor.constraint(equalTo: profileAvatar.trailingAnchor, constant: 5),
            
            secondNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 2),
            secondNameLabel.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: secondNameLabel.leadingAnchor),
            
            settingsButton.topAnchor.constraint(equalTo: profileAvatar.bottomAnchor, constant: 10),
            settingsButton.leadingAnchor.constraint(equalTo: profileAvatar.leadingAnchor, constant: 0),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func chooseAvatarInstanse(imageView: Bool) -> UIView {
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
        presenter.tapButton()
    }
    
    
}

extension ProfileViewController: ProfileViewControllerProtocol {
    func setProfileData(profile: Profile) {
        emailLabel.text = profile.email
        firstNameLabel.text = profile.firstName
        secondNameLabel.text = profile.secondName
    }
    
    func changeAvatarViewType() {
        if !(profileAvatar is UIImageView) {
            
            profileAvatar.removeFromSuperview()
            profileAvatar = chooseAvatarInstanse(imageView: true)
            view.addSubview(profileAvatar)
            
            configureConstraint()
            
        } else {
            print(false)
        }
    }
}
