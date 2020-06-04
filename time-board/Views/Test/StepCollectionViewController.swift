//
//  StepCollectionViewController.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class StepCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var steps:[Step] = [Step(title: "Step One", task: ["TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"]),Step(title: "Step One", task: ["TASK 1", "TASK 2"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionViewItem(with: view.bounds.size)
        
        
        //        self.collectionView.register(StepCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
        
        //        cell.setup(with: steps[indexPath.item])
        //        cell.parentVC = self
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard  let cell = collectionView.cellForItem(at: indexPath) as? StepCollectionViewCell else {
//             return CGSize(width: 225, height: view.bounds.height * 0.8)
//        }
//
//        return cell.tableView.contentSize
//    }
}
