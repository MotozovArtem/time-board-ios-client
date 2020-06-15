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
        layout.itemSize = CGSize(width: size.width / 2, height: size.height * 0.8)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        cell.setup(steps[indexPath.row])
        cell.parentVC = self
        return cell
    }
}
