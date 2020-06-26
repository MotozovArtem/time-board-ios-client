//
//  TaskDetailView.swift
//  time-board
//
//  Created by Tianid on 25.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TaskDetailView: UIView {

    //MARK: - Properties
    private var taskNameLabel: UILabel! = {
        let label = UILabel()
        label.text = "name"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
       return label
    }()
    
    private var descriptionWordLabel: UILabel! = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.text = "some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt    some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt    some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt   some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt   some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt some description with loooooooooooooooooooooooooooooooooooong 12312312312312 44545454 456 tteeeeeeeeeeeeeeeeeeexxxxxxxxxxtttttttt"
        label.numberOfLines = 0
        return label
    }()
    
    private var commentLabel: UILabel! = {
       let label = UILabel()
        label.text = "Comment"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: CGRect())
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    private func setupConstraints() {
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionWordLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(taskNameLabel)
        self.addSubview(descriptionWordLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(commentLabel)
        
        taskNameLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                             leading: self.safeAreaLayoutGuide.leadingAnchor,
                             trailing: self.safeAreaLayoutGuide.trailingAnchor,
                             padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        descriptionWordLabel.anchor(top: taskNameLabel.bottomAnchor,
                                    leading: self.safeAreaLayoutGuide.leadingAnchor,
                                    trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                    padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        descriptionLabel.anchor(top: descriptionWordLabel.bottomAnchor,
                                   leading: self.safeAreaLayoutGuide.leadingAnchor,
                                   trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                   padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        commentLabel.anchor(top: descriptionLabel.bottomAnchor,
                            leading: self.safeAreaLayoutGuide.leadingAnchor,
                            bottom: self.bottomAnchor,
                            trailing: self.safeAreaLayoutGuide.trailingAnchor,
                            padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
    }
}
