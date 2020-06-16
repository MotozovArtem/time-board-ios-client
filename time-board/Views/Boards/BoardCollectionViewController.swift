//
//  StepCollectionViewController.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices

enum BoardVCType {
    case PersonalProject, CommonProject
}

class BoardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var presenter: BoardCollectionPresenterProtocol?
    
    private var steps:[Board] = [Board(title: "Step One", task: ["TASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2", "TASK 3"]),Board(title: "Step One", task: ["TASK 1", "TASK 2","TASK 3","TASK 4"]),Board(title: "Step One", task: ["TASK 1","TASK 2","TASK 3","TASK 4", "TASK 5"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: [])]
    
    class func customInit(typeOfSteps: BoardVCType) -> BoardCollectionViewController {
        let stepVC = UIStoryboard(name: "Step", bundle: nil).instantiateViewController(withIdentifier: "StepVC") as! BoardCollectionViewController
        switch  typeOfSteps {
        case .PersonalProject:
            stepVC.steps = [Board(title: "In progress", task: []), Board(title: "Done", task: [])]
        case .CommonProject:
            stepVC.steps = [Board(title: "To do", task: []),
                            Board(title: "In progress", task: []),
                            Board(title: "Done", task: [])]
        }
        return stepVC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionViewItem(with: view.bounds.size)
        presenter = BoardCollectionPresenter(collection: self)
        collectionView.register(UINib(nibName: "AddListButtonViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
        //        self.collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        layout.itemSize = CGSize(width: size.width / 2, height: size.height * 0.72)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count + 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == steps.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! AddListButtonViewCollectionViewCell
            cell.parentVC = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        cell.setup(steps[indexPath.row])
        cell.parentVC = self
        return cell
    }
}

extension BoardCollectionViewController: BoardCollectionControllerProtocol {
    func showAlertForNewList() {
        let alert = UIAlertController(title: "List name", message: "Enter list name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
            let textField = alert.textFields![0]
            self?.presenter?.addListButtonAction(title: textField.text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func insertNewList(title: String) {
        steps.append(Board(title: title, task: []))
        collectionView.insertItems(at: [IndexPath(row: steps.count - 1, section: 0)])
    }
}
