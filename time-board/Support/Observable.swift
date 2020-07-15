//
//  Observable.swift
//  time-board
//
//  Created by Tianid on 06.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class Observable<T> {
    
    //MARK: - Properties
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> ())?
    
    //MARK: - Init

    init(_ value: T) {
        self.value = value
    }
    
    //MARK: - Func

    func bind (_ closure: @escaping (T) -> ()) {
        closure(value)
        listener = closure
    }
}
