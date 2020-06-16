//
//  BoardCollectionPresenter.swift
//  time-board
//
//  Created by Tianid on 16.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class BoardCollectionPresenter: BoardCollectionPresenterProtocol {
    
    private weak var collection: BoardCollectionControllerProtocol?
    
    func addListButtonAction(title: String) {
        guard title.count != 0 else { return }
        collection?.insertNewList(title: title)
    }
    init(collection: BoardCollectionControllerProtocol) {
        self.collection = collection
    }
    
    
}
