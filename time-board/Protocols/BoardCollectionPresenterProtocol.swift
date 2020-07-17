//
//  BoardCollectionPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import  UIKit

protocol BoardCollectionPresenterProtocol {
    var boards: [Board] { get }
    func addListActionTapped(title: String)
    func deleteListActionTapped(indexPath: IndexPath)
    func moveListLeftActionTapped(indexPath: IndexPath)
    func moveListRightActionTapped(indexPath: IndexPath)
    func renameActionTapped(title: String?, indexPath: IndexPath)
}

protocol AddListButtonViewPresenterProtocol {
    func addListButtonTapped()
}

protocol BoardCollectionViewCellPresenterProtocol {
    var boardType: BoardVCType { get }
    func settingsBoardButtonTapped(cell: BoardCollectionViewCellProtocol)
    func taskCellTapped(_ view: UIViewController)
}
