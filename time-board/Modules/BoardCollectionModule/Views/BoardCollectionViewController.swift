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
    //MARK: Delete Test after all
    case PersonalProject, CommonProject, Test
}

class BoardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    var presenter: IBoardCollectionPresenter?
    private var typeOfBoard: BoardVCType = .CommonProject
    
    
    //MARK: - Func
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: size.width / 2, height: size.height * 0.72)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionViewItem(with: view.bounds.size)
        collectionView.register(UINib(nibName: "AddListButtonViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: Delete Test after all
        if typeOfBoard == .CommonProject || typeOfBoard == .Test {
            return (presenter?.boards.count)! + 1
        }
        return (presenter?.boards.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: Delete Test after all
        if indexPath.row == (presenter?.boards.count) && (typeOfBoard == .CommonProject || typeOfBoard == .Test) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! AddListButtonViewCollectionViewCell
            cell.presenter = presenter as? IAddListButtonViewPresenter
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        cell.setup((presenter?.boards[indexPath.row])!)
        cell.presenter = presenter as? IBoardCollectionViewCellPresenter
        
        return cell
    }
}

extension BoardCollectionViewController: IBoardCollectionController {
    func showSettingsListAlert(cell: IBoardCollectionViewCell) {
        guard let kitCell = cell as? UICollectionViewCell else { return }
        guard let indexPath = collectionView.indexPath(for: kitCell ) else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete list", style: .default) { [weak self] (_) in
            self?.presenter?.deleteListActionTapped(indexPath: indexPath)
        }
        let renameAction = UIAlertAction(title: "Rename list", style: .default, handler: { [weak self] (_) in
            let alert = UIAlertController(title: "Set new name", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
                let textField = alert.textFields![0]
                self?.presenter?.renameActionTapped(title: textField.text, indexPath: indexPath)
            }))
            
            self?.present(alert, animated: true, completion: nil)

            
        })
        
        if indexPath.row != 0 {
            let moveLeftAction = UIAlertAction(title: "Move left list", style: .default, handler: { [weak self] (_) in
                self?.presenter?.moveListLeftActionTapped(indexPath: indexPath)
            })
            alert.addAction(moveLeftAction)
        }
        
        if indexPath.row != (presenter?.boards.count)! - 1 {
            let moveRightAction = UIAlertAction(title: "Move right list", style: .default, handler: { [weak self] (_) in
                self?.presenter?.moveListRightActionTapped(indexPath: indexPath)
            })
            alert.addAction(moveRightAction)
        }
        
        let title = cell.getTableViewEditingStatus() ? "Cancel edit" : "Edit list"
        let editListAction = UIAlertAction(title: title, style: .default, handler: { _ in
            cell.switchTableViewCellisEditable()
        })
        
        alert.addAction(renameAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        alert.addAction(editListAction)
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
        collectionView.insertItems(at: [IndexPath(row: (presenter?.boards.count)! - 1, section: 0)])
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
    
    func refreshCell(indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
