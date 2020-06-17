//
//  BoardCollectionPresenterProtocol.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import  UIKit

protocol BoardCollectionPresenterProtocol {
    var steps: [Board] { get }
    func addListActionTapped(title: String)
    func deleteListActionTapped(indexPath: IndexPath)
    func moveListLeftActionTapped(indexPath: IndexPath)
    func moveListRightActionTapped(indexPath: IndexPath)
}

protocol AddListButtonViewProtocol {
    func addListButtonTapped()
}

protocol BoardCollectionViewCellProtocol {
    var boardType: BoardVCType { get }
    func settingsBoardButtonTapped(cell: UICollectionViewCell)
}
