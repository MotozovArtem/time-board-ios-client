//
//  IsshuesPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class IsshuesPresenter: IIsshuesPresenter {
    //MARK: - Properties
    private let router: IRouter
    private weak var parent: IIsshuesViewController?
    //MARK: - Init
    
    init(view: IIsshuesViewController, router: IRouter) {
        self.parent = view
        self.router = router
    }
    
    //MARK: - Func
    
    
}
