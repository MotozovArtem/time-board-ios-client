//
//  AttachmentCellProtocol.swift
//  time-board
//
//  Created by Tianid on 07.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol AttachmentCellProtocol: UICollectionViewCell {
    var presenter: DetailTaskPresenterProtocol? { get set }
}
