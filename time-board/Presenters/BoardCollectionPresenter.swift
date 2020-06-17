//
//  BoardCollectionPresenter.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BoardCollectionPresenter: BoardCollectionPresenterProtocol, AddListButtonViewProtocol, BoardCollectionViewCellProtocol {
    
    private(set) var steps:[Board] = [Board(title: "Step One", task: ["TASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASKTASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2","TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2", "TASK 3"]),Board(title: "Step One", task: ["TASK 1", "TASK 2","TASK 3","TASK 4"]),Board(title: "Step One", task: ["TASK 1","TASK 2","TASK 3","TASK 4", "TASK 5"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: ["TASK 1", "TASK 2"]),Board(title: "Step One", task: [])]
    
    
    private weak var collection: BoardCollectionControllerProtocol?
    var boardType: BoardVCType
    
    func addListActionTapped(title: String) {
        guard title.count != 0 else { return }
        steps.append(Board(title: title, task: []))
        collection?.insertNewList(title: title)
    }
    
    func deleteListActionTapped(indexPath: IndexPath) {
        steps.remove(at: indexPath.row)
        collection?.deleteList(indexPath: indexPath)
    }
    
    func settingsBoardButtonTapped(cell: UICollectionViewCell) {
        collection?.showSettingsListAlert(cell: cell)
    }
    
    func moveListLeftActionTapped(indexPath: IndexPath) {
        steps.swapAt(indexPath.row, indexPath.row - 1)
        collection?.moveListLeft(indexPath: indexPath)
    }
    
    func moveListRightActionTapped(indexPath: IndexPath) {
        steps.swapAt(indexPath.row, indexPath.row + 1)
        collection?.moveListRight(indexPath: indexPath)
    }
    
    func addListButtonTapped() {
        collection?.showAlertForNewList()
    }
    
    init(collection: BoardCollectionControllerProtocol, boardType: BoardVCType) {
        self.collection = collection
        self.boardType = boardType
        
        switch  boardType {
        case .PersonalProject:
            steps = [Board(title: "In progress", task: []), Board(title: "Done", task: [])]
        case .CommonProject:
            steps = [Board(title: "To do", task: []),
                     Board(title: "In progress", task: []),
                     Board(title: "Done", task: [])]
        case .Test:
            break
        }
    }
    
    
}
