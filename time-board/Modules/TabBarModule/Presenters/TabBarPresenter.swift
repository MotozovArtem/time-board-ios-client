//
//  TabBarPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class TabBarPresenter: ITabBarPresenter {
    //MARK: - Properties
    private weak var parent: ITabBarViewController?
    
    //MARK: - Init
    
    init(view: ITabBarViewController) {
        self.parent = view
    }
    
    //MARK: - Func
    
}
