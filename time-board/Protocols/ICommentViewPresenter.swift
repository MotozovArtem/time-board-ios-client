//
//  ICommentViewPresenter.swift
//  time-board
//
//  Created by Tianid on 23.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol ICommentViewPresenter {
    var comment: Comment { get set }
    func getImage(indexPath: IndexPath) -> UIImage?
}
