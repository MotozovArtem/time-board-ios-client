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
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = self.view.convert(keyboardSize, from: nil)
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height + 20
            scrollView.contentInset = contentInset
            commentTextFieldView.frame.origin.y -= keyboardFrame.height
        }
        keyboardIsHidden = false
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.commentTextFieldView.frame.origin.y += keyboardSize.height
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

