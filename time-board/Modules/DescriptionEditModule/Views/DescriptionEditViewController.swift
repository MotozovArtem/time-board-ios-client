//
//  DescriptionEditViewController.swift
//  time-board
//
//  Created by Tianid on 16.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DescriptionEditViewController: UIViewController {
    //MARK: - Properties
//    private let task: Task
    var presenter: IDescriptionEditPresenter?
    private let placeholder = "Enter description"
    private var textView: UITextView! = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        return textView
    }()
    
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
    //MARK: - Func
    
    private func setupConstraint() {
        view.addSubview(textView)
        
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped)), animated: false)
    }
    
    private func setupTextView() {
        textView.delegate = self
        if presenter?.task.taskDescription?.count != 0 {
            textView.text = presenter?.task.taskDescription
        } else {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    @objc private func doneButtonTapped() {
        guard let text = textView.text else { return }
        presenter?.task.taskDescription = text
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        textView.scrollIndicatorInsets = self.textView.contentInset
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        textView.contentInset = contentInsets
        textView.scrollIndicatorInsets = contentInsets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
        addObservers()
        setupNavigationBar()
        setupTextView()
        // Do any additional setup after loading the view.
    }
}

extension DescriptionEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.textColor = .black
            textView.text = ""
        }
    }
}

extension DescriptionEditViewController: IDescriptionEditViewController {
    
}
