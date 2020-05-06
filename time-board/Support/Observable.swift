//
//  Observable.swift
//  time-board
//
//  Created by Tianid on 06.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> ())?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind (_ closure: @escaping (T) -> ()) {
        closure(value)
        listener = closure
    }
}
