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
    case PersonalProject, CommonProject, Test
}

class BoardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var presenter: BoardCollectionPresenterProtocol?
    private var typeOfBoard: BoardVCType = .CommonProject
    
    class func customInit(typeOfSteps: BoardVCType) -> BoardCollectionViewController {
        let stepVC = UIStoryboard(name: "Board", bundle: nil).instantiateViewController(withIdentifier: "BoardVC") as! BoardCollectionViewController
        stepVC.presenter = BoardCollectionPresenter(collection: stepVC, boardType: typeOfSteps)
        stepVC.typeOfBoard = typeOfSteps
        return stepVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionViewItem(with: view.bounds.size)
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
        if typeOfBoard == .CommonProject {
            return (presenter?.steps.count)! + 1
        }
        return (presenter?.steps.count)!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == (presenter?.steps.count) && typeOfBoard == .CommonProject {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! AddListButtonViewCollectionViewCell
            cell.presenter = presenter as? AddListButtonViewProtocol
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        cell.setup((presenter?.steps[indexPath.row])!)
        cell.presenter = presenter as? BoardCollectionViewCellProtocol
        
        return cell
    }
}

extension BoardCollectionViewController: BoardCollectionControllerProtocol {
    func showSettingsListAlert(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete list", style: .default) { [weak self] (_) in
            self?.presenter?.deleteListActionTapped(indexPath: indexPath)
        }
        let renameAction = UIAlertAction(title: "Rename list", style: .default, handler: nil)
        
        if indexPath.row != 0 {
            let moveLeftAction = UIAlertAction(title: "Move left list", style: .default, handler: { [weak self] (_) in
                self?.presenter?.moveListLeftActionTapped(indexPath: indexPath)
            })
            alert.addAction(moveLeftAction)
        }
        
        if indexPath.row != (presenter?.steps.count)! - 1 {
            let moveRightAction = UIAlertAction(title: "Move right list", style: .default, handler: { [weak self] (_) in
                self?.presenter?.moveListRightActionTapped(indexPath: indexPath)
            })
            alert.addAction(moveRightAction)
        }
        alert.addAction(renameAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForNewList() {
        let alert = UIAlertController(title: "List name", message: "Enter list name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
            let textField = alert.textFields![0]
            self?.presenter?.addListActionTapped(title: textField.text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func insertNewList(title: String) {
        collectionView.insertItems(at: [IndexPath(row: (presenter?.steps.count)! - 1, section: 0)])
    }
    
    func deleteList(indexPath: IndexPath) {
        collectionView.deleteItems(at: [indexPath])
    }
    
    func moveListLeft(indexPath: IndexPath) {
        let to = IndexPath(row: indexPath.row - 1, section: 0)
        collectionView.moveItem(at: indexPath, to: to)
        collectionView.scrollToItem(at: to, at: .centeredHorizontally, animated: true)
    }
    
    func moveListRight(indexPath: IndexPath) {
        let to = IndexPath(row: indexPath.row + 1, section: 0)
        collectionView.moveItem(at: indexPath, to: to)
        collectionView.scrollToItem(at: to, at: .centeredHorizontally, animated: true)
    }
}
