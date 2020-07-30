//
//  TabBarPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class TabBarPresenter: ITabBarPresenter {
    //MARK: - Properties
    private let router: IRouter
    private weak var parent: ITabBarViewController?
    
    //MARK: - Init
    
    init(view: ITabBarViewController, router: IRouter) {
        self.parent = view
        self.router = router
    }
    
    //MARK: - Func
    
}
