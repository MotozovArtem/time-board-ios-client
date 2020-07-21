//
//  BoardCollectionPresenter.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BoardCollectionPresenter: IBoardCollectionPresenter, IAddListButtonViewPresenter, IBoardCollectionViewCellPresenter {
    
    // MARK: - Properties
    
    private(set) var boards:[Board] = testBoards
    
    private weak var collection: IBoardCollectionController?
    var boardType: BoardVCType
    
    // MARK: - Init
    
    init(collection: IBoardCollectionController, boardType: BoardVCType) {
        self.collection = collection
        self.boardType = boardType
        
        switch  boardType {
        case .PersonalProject:
            boards = [Board(title: "In progress", task: []), Board(title: "Done", task: [])]
        case .CommonProject:
            boards = [Board(title: "To do", task: []),
                     Board(title: "In progress", task: []),
                     Board(title: "Done", task: [])]
        case .Test:
            break
        }
    }
    
    // MARK: - Func

    func addListActionTapped(title: String) {
        guard title.count != 0 else { return }
        boards.append(Board(title: title, task: []))
        collection?.insertNewList(title: title)
    }
    
    func deleteListActionTapped(indexPath: IndexPath) {
        boards.remove(at: indexPath.row)
        collection?.deleteList(indexPath: indexPath)
    }
    
    func settingsBoardButtonTapped(cell: IBoardCollectionViewCell) {
        collection?.showSettingsListAlert(cell: cell)
    }
    
    func moveListLeftActionTapped(indexPath: IndexPath) {
        boards.swapAt(indexPath.row, indexPath.row - 1)
        collection?.moveListLeft(indexPath: indexPath)
    }
    
    func moveListRightActionTapped(indexPath: IndexPath) {
        boards.swapAt(indexPath.row, indexPath.row + 1)
        collection?.moveListRight(indexPath: indexPath)
    }
    
    func addListButtonTapped() {
        collection?.showAlertForNewList()
    }
    
    func renameActionTapped(title: String?, indexPath: IndexPath) {
        guard let title = title else { return }
        boards[indexPath.row].title = title
        collection?.refreshCell(indexPath: indexPath)
    }
    
    func taskCellTapped(_ view: UIViewController) {
        collection?.showTaskDetailViewController(view)
    }
}
