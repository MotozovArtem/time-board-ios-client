//
//  NotificationsPresenter.swift
//  time-board
//
//  Created by Tianid on 29.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class NotificationsPresenter: INotificationsPresenter {
    //MARK: - Properties
    private let router: IRouter
    private weak var parent: INotificationsViewController?
    
    //MARK: - Init
    
    init(view: INotificationsViewController, router: IRouter) {
        self.parent = view
        self.router = router
    }
    
    //MARK: - Func
    
    
}
