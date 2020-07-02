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
    private var testComments = commentsArray
    
    private var attachments: [String]!
    private var comments: [String]!
    
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
        label.text = "some description with "
        label.numberOfLines = 0
        return label
    }()
    
    private var attachmentView: AttachmentView! = {
        let view = AttachmentView()
        return view
    }()
    
    private var commentLabel: UILabel! = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private var verticalStack: UIStackView! = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
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
        attachmentView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(taskNameLabel)
        self.addSubview(descriptionWordLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(attachmentView)
        self.addSubview(commentLabel)
        self.addSubview(verticalStack)
        
        
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
        
        attachmentView.anchor(top: descriptionLabel.bottomAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        commentLabel.anchor(top: attachmentView.bottomAnchor,
                            leading: self.safeAreaLayoutGuide.leadingAnchor,
                            trailing: self.safeAreaLayoutGuide.trailingAnchor,
                            padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        verticalStack.anchor(top: commentLabel.bottomAnchor,
                             leading: self.safeAreaLayoutGuide.leadingAnchor,
                             bottom: self.safeAreaLayoutGuide.bottomAnchor,
                             trailing: self.safeAreaLayoutGuide.trailingAnchor,
                             padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    
    func addNewCommentView(comment: String) {
        let view = CommentView()
        view.text = comment
        self.verticalStack.addArrangedSubview(view)
    }
    
    func setDataSource(taskName: String, description: String, attachments: [String], comments: [String]) {
        taskNameLabel.text = taskName
        descriptionLabel.text = description
        self.attachments = attachments
        self.comments = comments
        
    }
}
