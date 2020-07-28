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
    
    private weak var superView: IBoardCollectionController!
    var boardType: BoardVCType
    
    // MARK: - Init
    
    init(superView: IBoardCollectionController, boardType: BoardVCType) {
        self.superView = superView
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
        superView?.insertNewList(title: title)
    }
    
    func deleteListActionTapped(indexPath: IndexPath) {
        boards.remove(at: indexPath.row)
        superView?.deleteList(indexPath: indexPath)
    }
    
    func settingsBoardButtonTapped(cell: IBoardCollectionViewCell) {
        superView?.showSettingsListAlert(cell: cell)
    }
    
    func moveListLeftActionTapped(indexPath: IndexPath) {
        boards.swapAt(indexPath.row, indexPath.row - 1)
        superView?.moveListLeft(indexPath: indexPath)
    }
    
    func moveListRightActionTapped(indexPath: IndexPath) {
        boards.swapAt(indexPath.row, indexPath.row + 1)
        superView?.moveListRight(indexPath: indexPath)
    }
    
    func addListButtonTapped() {
        superView?.showAlertForNewList()
    }
    
    func renameActionTapped(title: String?, indexPath: IndexPath) {
        guard let title = title else { return }
        boards[indexPath.row].title = title
        superView?.refreshCell(indexPath: indexPath)
    }
    
    func taskCellTapped(_ view: UIViewController) {
        superView.showTaskDetailViewController(view)
    }
}
