//
//  StringOptional+Utils.swift
//  time-board
//
//  Created by Tianid on 19.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    func verification(_ expression: String?, required:Bool = false) -> Bool {
        //when text is empty
        if required && (self == nil || self == "") { return false } // text required
        guard let text = self else { return true }
        guard text.count > 0 else { return true } // text no required end text is empty ("")
        guard let expression = expression else { return true } // no expression
        
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", expression)
        let result = predicate.evaluate(with: self)
        return result
    }
}
