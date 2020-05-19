//
//  TBTextField.swift
//  time-board
//
//  Created by Tianid on 19.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

enum ExpressionType {
    case emailRegEx
    case loginRegEx
    case passwordRegEx
    case empty
}

class TBTextField: UITextField {
    
    //MARK: - Properties
    
    var borderMistakeColor: UIColor = .red
    var borderEmptyColor: UIColor = .lightGray
    var borderFilledColor: UIColor = .green
    
    
    private let emailRegEx = #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
    
    private let loginRegEx = #"^(?![_ -])(?:(?![_ -]{2})[\w -]){5,16}(?<![_ -])$"#
    private let passwordRegEx = #"^(?:(?=.*?\p{N})(?=.*?[\p{S}\p{P} ])(?=.*?\p{Lu})(?=.*?\p{Ll}))[^\p{C}]{8,16}$"#
    private var fieldType: ExpressionType
    
    private var expression: String {
        get {
            switch fieldType {
            case .emailRegEx:
                return emailRegEx
            case .loginRegEx:
                return loginRegEx
            case .passwordRegEx:
                return passwordRegEx
            case .empty:
                return String()
            }
            
        }
    }
    
    var isValid: Bool {
        return self.text.verification(expression)
    }
    
    //MARK: - Init
    convenience init(fieldType: ExpressionType, frame: CGRect) {
        self.init(frame: frame)
        self.fieldType = fieldType
    }
    override init(frame: CGRect) {
        self.fieldType = .empty
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    func setFieldType(fieldType: ExpressionType) {
        self.fieldType = fieldType
    }
    
}
