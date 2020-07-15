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
    case nameRegEx
    case empty
}

class TBTextField: UITextField {
    
    //MARK: - Properties
    
    private var borderMistakeColor: UIColor = .red
    private var borderEmptyColor: UIColor = .lightGray
    private var borderFilledColor: UIColor = .green
    private var valueRequired: Bool = true
    
    
    private let emailRegEx = #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
    
    private let loginRegEx = #"^(?![_ -])(?:(?![_ -]{2})[\w -]){5,}(?<![_ -])$"#
    private let passwordRegEx = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
    private let nameRegEx = "^([a-zA-Z ]){2,30}$"
    private var fieldType: ExpressionType
    
    weak var validateManager: IValidateManager?
    
    private var expression: String {
        get {
            switch fieldType {
            case .emailRegEx:
                return emailRegEx
            case .loginRegEx:
                return loginRegEx
            case .passwordRegEx:
                return passwordRegEx
            case .nameRegEx:
                return nameRegEx
            case .empty:
                return String()
            }
            
        }
    }
    
    
    //MARK: - Init
    convenience init(fieldType: ExpressionType, frame: CGRect) {
        self.init(frame: frame)
        self.fieldType = fieldType
    }
    override init(frame: CGRect) {
        self.fieldType = .empty
        super.init(frame: frame)
        adjustView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    func setFieldType(fieldType: ExpressionType) {
        self.fieldType = fieldType
    }
    
    private func adjustView() {
        self.addTarget(self, action: #selector(textEditAction(_:)), for: .editingChanged)
        self.addTarget(self, action: #selector(textEditEndedAction(_:)), for: .editingDidEnd)
    }
        
    private func setSenderBorderSetups(_ sender: UITextField) {
        
        if !self.isValid {
            
            if let text = sender.text, text.count == 0 {
                sender.layer.borderColor = self.borderEmptyColor.cgColor
                sender.layer.borderWidth = 0
                sender.layer.cornerRadius = 0
                return
            }
            sender.layer.borderColor = self.borderMistakeColor.cgColor
            sender.layer.borderWidth = 1
            sender.layer.cornerRadius = sender.frame.size.height / 6
            return
        }
        
        if let text = sender.text, text.count > 0 {
            sender.layer.borderColor = self.borderFilledColor.cgColor
            sender.layer.borderWidth = 1
            sender.layer.cornerRadius = sender.frame.size.height / 6
            return
        }
    }
    
    @objc private func textEditAction(_ sender: UITextField) {
        guard let validateManager = validateManager else { return }
        setSenderBorderSetups(sender)
        validateManager.verificated()
    }
    
    @objc private func textEditEndedAction(_ sender: UITextField) {
        
    }
}

extension TBTextField: IValidatable {
    
    var isValid: Bool {
        return self.text.verification(expression, required: valueRequired)
    }
}
