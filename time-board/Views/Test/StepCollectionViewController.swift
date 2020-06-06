//
//  StepCollectionViewController.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices

class StepCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var steps:[Step] = [Step(title: "Step One", task: ["TASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2", "TASK 3"]),Step(title: "Step One", task: ["TASK 1", "TASK 2","TASK 3","TASK 4"]),Step(title: "Step One", task: ["TASK 1","TASK 2","TASK 3","TASK 4", "TASK 5"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: [])]
    
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
        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StepCollectionViewCell
        cell.setup(steps[indexPath.row])
        cell.parentVC = self
        return cell
    }
}
