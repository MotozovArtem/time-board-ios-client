//
//  ProjectsPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class ProjectsPresenter: IProjectsPresenter {
    //MARK: - Properties
    private weak var parent: IProjectsViewController?
    //MARK: - Init
    init(view: IProjectsViewController) {
        self.parent = view
    }
    //MARK: - Func
}
