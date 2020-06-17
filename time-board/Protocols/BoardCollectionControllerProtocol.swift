//
//  BoardCollectionControllerProtocol.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol BoardCollectionControllerProtocol: class {
    func insertNewList(title: String)
    func showAlertForNewList()
    func showSettingsListAlert(cell: UICollectionViewCell)
    func deleteList(indexPath: IndexPath)
    func moveListLeft(indexPath: IndexPath)
    func moveListRight(indexPath: IndexPath)
}