//
//  DetailViewViewController.swift
//  time-board
//
//  Created by Tianid on 25.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {
    
    //MARK: - Properties
    private var keyboardIsHidden = true
    
    private lazy var detailView: TaskDetailView = {
        return TaskDetailView()
    }()
    
    private lazy var scrollView: UIScrollView! = {
        return UIScrollView()
    }()
    
    private var commentTextFieldView: CommentTextFieldView! = {
        let view = CommentTextFieldView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
        return CommentTextFieldView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TEST"
        setupViews()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeDetail(_:)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Func
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        commentTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        view.addSubview(commentTextFieldView)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: commentTextFieldView.topAnchor,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //                          centerY: view.centerYAnchor
        )
        
        detailView.anchor(top: scrollView.topAnchor,
                          leading: scrollView.leadingAnchor,
                          bottom: scrollView.bottomAnchor,
                          trailing: scrollView.trailingAnchor)
        
        commentTextFieldView.anchor(
            //            top: scrollView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
        
        
        scrollView.backgroundColor = .red
        detailView.backgroundColor = .green
        commentTextFieldView.backgroundColor = .white
        
        detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        
        if self.view.frame.origin.y == 0 {
            var contentInsets = UIEdgeInsets()
            contentInsets = UIEdgeInsets(top: keyboardSize.height, left: 0.0, bottom: 0.0, right: 0.0)
            scrollView.contentInset = contentInsets
            view.frame.origin.y -= keyboardSize.height
        }
        keyboardIsHidden = false
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        if self.view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
        keyboardIsHidden = true
    }
    
    @objc private func closeDetail(_ navBar: UINavigationBar) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

