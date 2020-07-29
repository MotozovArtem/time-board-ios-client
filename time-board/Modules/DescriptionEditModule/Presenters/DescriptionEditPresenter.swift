//
//  DescriptionEditPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


class DescriptionEditPresenter: IDescriptionEditPresenter {
    //MARK: - Properties
    var task: Task
    private weak var parent: IDescriptionEditViewController?
    
    //MARK: - Init
    init(view: IDescriptionEditViewController, task: Task) {
        self.task = task
        self.parent = view
    }
}
