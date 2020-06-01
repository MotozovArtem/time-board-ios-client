//
//  ViewController.swift
//  time-board
//
//  Created by Tianid on 16.04.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Propertiec
    //MARK: - Functions
    var testView: TaskViewContainer?
    var but1: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("But1", for: .normal)
        return button
    }()
    
    var but2: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("But2", for: .normal)
        return button
    }()
    
    
    lazy var task: TaskViewContainer! = {
        return getContainerView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        task.taskTableView.delegate = task
        task.taskTableView.dataSource = task
        
        view.addSubview(task)
//        view.addSubview(but1)
//        view.addSubview(but2)

        task.translatesAutoresizingMaskIntoConstraints = false
        but1.translatesAutoresizingMaskIntoConstraints = false
        but2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            task.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            task.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            task.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            ])
        
//        task.anchor(top: view.topAnchor,
//                    leading: view.leadingAnchor,
//                    trailing: view.trailingAnchor,
//                    padding: UIEdgeInsets(top: 30, left: 8, bottom: 300, right: 8),
//                    centerX: nil,
//                    centerY: nil)
        
//        but1.anchor(top: task.bottomAnchor,
//                    leading: view.leadingAnchor,
//                    padding: UIEdgeInsets(top: 10, left: 8, bottom: 0, right: 0),
//                    size: CGSize(width: 100, height: 50))
//        but2.anchor(top: task.bottomAnchor,
//                    trailing: view.trailingAnchor,
//                    padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 8),
//                    size: CGSize(width: 100, height: 50))
        //        view.addSubview(testView!)
        // Do any additional setup after loading the view.
    }
    
    private func getContainerView() -> TaskViewContainer {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "TaskViewContainer", bundle: bundle)
        let task = (nib.instantiate(withOwner: self, options: nil)[0] as! TaskViewContainer)
        return task
    }
    
}

