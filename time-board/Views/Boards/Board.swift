//
//  Step.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


class Board {
    var title: String
    var task: [Task]
    
    init(title: String, task: [Task]) {
        self.title = title
        self.task = task
    }
}
