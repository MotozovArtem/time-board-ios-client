//
//  BoardCollectionViewCellProtocol.swift
//  time-board
//
//  Created by Tianid on 17.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IBoardCollectionViewCell: class {
    func switchTableViewCellisEditable()
    func getTableViewEditingStatus() -> Bool
}
