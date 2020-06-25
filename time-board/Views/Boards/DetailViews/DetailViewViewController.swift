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
    private lazy var detailView: TaskDetailView = {
        return TaskDetailView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TEST"
        setupViews()
    }
    
    //MARK: - Func
    
    private func setupViews() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        detailView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .zero)
        detailView.backgroundColor = .green
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeDetail(_:)))
//        navigationController?.navigationBar.setItems([test], animated: true)
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
}

/*
 top: view.safeAreaLayoutGuide.topAnchor,
 leading: view.safeAreaLayoutGuide.leadingAnchor,
 bottom: view.safeAreaLayoutGuide.bottomAnchor,
 trailing: view.safeAreaLayoutGuide.trailingAnchor,
 */
